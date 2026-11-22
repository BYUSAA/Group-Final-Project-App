import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  const Subject({required this.id, required this.name, required this.programme, this.tutorCount = 0, this.isActive = true});
  final String id;
  final String name;
  final String programme;
  final int tutorCount;
  final bool isActive;
  @override
  List<Object?> get props => [id, name, programme, tutorCount, isActive];
}
