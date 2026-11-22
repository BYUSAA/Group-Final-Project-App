import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/avatar_initials.dart';
import '../../../../core/widgets/chip_selector.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/rating_stars.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/session_repository.dart';
import '../../domain/usecases/get_session_details.dart';
import '../bloc/my_sessions/my_sessions_bloc.dart';
import '../bloc/my_sessions/my_sessions_event.dart';
import '../bloc/rating/rating_bloc.dart';
import '../bloc/rating/rating_event.dart';
import '../bloc/rating/rating_state.dart';

class RateSessionPage extends StatefulWidget {
  const RateSessionPage({required this.sessionId, super.key});
  final String sessionId;
  @override
  State<RateSessionPage> createState() => _RateSessionPageState();
}
class _RateSessionPageState extends State<RateSessionPage> {
  late final Future<Session> _sessionFuture;
  int _rating = 4;
  String _unstuck = 'Yes';
  final Set<String> _tags = {'Clear explanations'};
  final _comment = TextEditingController();
  static const options = ['Clear explanations','Patient','On time','Well prepared','Easy to ask questions'];

  @override
  void initState() {
    super.initState();
    _sessionFuture = GetSessionDetails(sl<SessionRepository>())(widget.sessionId);
  }
  @override
  void dispose() { _comment.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.background,
    body: SafeArea(child: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: FutureBuilder<Session>(
        future: _sessionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator(color: AppColors.green));
          if (snapshot.hasError || !snapshot.hasData) return Center(child: Text(snapshot.error?.toString() ?? 'Session not found.'));
          final session = snapshot.data!;
          return BlocConsumer<RatingBloc, RatingState>(
            listener: (context, state) {
              if (state.status == RatingStatus.success) {
                final auth = context.read<AuthBloc>().state;
                if (auth is AuthAuthenticated) {
                  context.read<MySessionsBloc>().add(MySessionsRequested(auth.user.uid));
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? 'Thank you for your feedback.')));
                context.go('/sessions');
              }
              if (state.status == RatingStatus.failure) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? 'Could not submit rating.')));
            },
            builder: (context, ratingState) => Column(children: [
              Expanded(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 16, 20, 18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconButton(onPressed: () => context.pop(), padding: EdgeInsets.zero, alignment: Alignment.centerLeft, icon: const Icon(Icons.close_rounded)),
                const SizedBox(height: 18),
                Center(child: AvatarInitials(name: session.tutorName, size: 60, backgroundColor: AppColors.mint)),
                const SizedBox(height: 9),
                Text('How was your session with ${session.tutorName.split(' ').first}?', textAlign: TextAlign.center, style: AppTextStyles.pageTitle.copyWith(fontSize: 22)),
                const SizedBox(height: 8),
                Center(child: Text('${session.subjectName} · ${session.startAt.day} Sep · ${session.mode}', style: AppTextStyles.caption)),
                const SizedBox(height: 19),
                Center(child: RatingStars(rating: _rating, onChanged: (v) => setState(() => _rating = v), size: 34)),
                Center(child: Text(_rating >= 4 ? 'Helpful' : _rating == 3 ? 'Good' : 'Could be better', style: AppTextStyles.caption)),
                const SizedBox(height: 20),
                const Text('Did you get unstuck?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 8),
                ChipSelector(options: const ['Yes','Partly','No'], selected: {_unstuck}, onSelected: (v) => setState(() => _unstuck = v)),
                const SizedBox(height: 18),
                const Text('What went well?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 8),
                ChipSelector(options: options, selected: _tags, onSelected: (v) => setState(() => _tags.contains(v) ? _tags.remove(v) : _tags.add(v))),
                const SizedBox(height: 18),
                const Text('Anything else? (optional)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                const SizedBox(height: 8),
                TextField(controller: _comment, maxLines: 3, decoration: const InputDecoration(hintText: 'A short note for your tutor')),
              ]))),
              Padding(padding: const EdgeInsets.fromLTRB(18, 10, 18, 14), child: PrimaryButton(
                label: 'Submit rating',
                isLoading: ratingState.status == RatingStatus.submitting,
                onPressed: ratingState.status == RatingStatus.submitting ? null : () {
                  final auth = context.read<AuthBloc>().state;
                  final studentId = auth is AuthAuthenticated ? auth.user.uid : session.studentId;
                  context.read<RatingBloc>().add(RatingSubmitted(
                    sessionId: session.id,
                    studentId: studentId,
                    tutorId: session.tutorId,
                    rating: _rating,
                    feedbackTags: [..._tags, 'Helped: $_unstuck'],
                    comment: _comment.text.trim(),
                  ));
                },
              )),
            ]),
          );
        },
      ),
    ))),
  );
}
