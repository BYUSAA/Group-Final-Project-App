import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/session.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({required this.session, required this.onTap, this.onRate, super.key});
  final Session session;
  final VoidCallback onTap;
  final VoidCallback? onRate;
  @override
  Widget build(BuildContext context) {
    final upcoming = session.status == SessionStatus.confirmed;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.border)),
      child: Column(children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(children: [
            Container(width: 54, height: 58, decoration: BoxDecoration(color: upcoming ? AppColors.green : AppColors.surfaceSoft, borderRadius: BorderRadius.circular(12)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(DateFormat('EEE').format(session.startAt).toUpperCase(), style: TextStyle(color: upcoming ? Colors.white70 : AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w700)),
              Text('${session.startAt.day}', style: TextStyle(color: upcoming ? Colors.white : AppColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
            ])),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(session.subjectName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.text)),
              const SizedBox(height: 4),
              Text('${session.tutorName} · ${DateFormat('HH:mm').format(session.startAt)}', style: AppTextStyles.caption),
              const SizedBox(height: 3),
              Text(session.location, style: AppTextStyles.caption),
            ])),
            if (session.rating != null)
              Row(children: [const Icon(Icons.star_rounded, size: 16, color: AppColors.star), Text(' ${session.rating}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))])
            else
              const Icon(Icons.chevron_right_rounded, color: AppColors.green),
          ]),
        ),
        if (session.status == SessionStatus.completed && session.rating == null && onRate != null) ...[
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, height: 40, child: FilledButton.tonalIcon(
            onPressed: onRate,
            style: FilledButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: const Color(0xFF684D1B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            icon: const Icon(Icons.star_border_rounded, size: 17),
            label: const Text('Rate this session', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          )),
        ],
      ]),
    );
  }
}
