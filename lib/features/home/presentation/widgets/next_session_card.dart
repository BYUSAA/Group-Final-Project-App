import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../sessions/domain/entities/session.dart';
import '../../../../core/widgets/avatar_initials.dart';

class NextSessionCard extends StatelessWidget {
  const NextSessionCard({required this.session, required this.onTap, super.key});
  final Session? session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final current = session;
    return Material(
      color: AppColors.green,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: current == null ? null : onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: current == null
              ? const Text('No upcoming sessions yet. Find a peer tutor when you need help.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('YOUR NEXT SESSION', style: TextStyle(color: Color(0xFFD2E2DA), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .8)),
                  const SizedBox(height: 8),
                  Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(current.subjectName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 5),
                      Text('with ${current.tutorName}', style: const TextStyle(color: Colors.white, fontSize: 13)),
                    ])),
                    AvatarInitials(name: current.tutorName, size: 43),
                  ]),
                  const SizedBox(height: 14),
                  Wrap(spacing: 16, runSpacing: 7, children: [
                    _Meta(icon: Icons.calendar_today_outlined, label: DateFormat('EEE d MMM · HH:mm').format(current.startAt)),
                    _Meta(icon: Icons.location_on_outlined, label: current.location),
                  ]),
                ]),
        ),
      ),
    );
  }
}
class _Meta extends StatelessWidget {
  const _Meta({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Icon(icon, size: 14, color: Colors.white70),
    const SizedBox(width: 5),
    Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
  ]);
}
