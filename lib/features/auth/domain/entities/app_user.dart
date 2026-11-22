import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.programme,
    required this.year,
    required this.isTutor,
    required this.emailVerified,
  });
  final String uid;
  final String name;
  final String email;
  final String programme;
  final int year;
  final bool isTutor;
  final bool emailVerified;

  AppUser copyWith({
    String? uid,
    String? name,
    String? email,
    String? programme,
    int? year,
    bool? isTutor,
    bool? emailVerified,
  }) => AppUser(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    programme: programme ?? this.programme,
    year: year ?? this.year,
    isTutor: isTutor ?? this.isTutor,
    emailVerified: emailVerified ?? this.emailVerified,
  );

  @override
  List<Object?> get props => [uid, name, email, programme, year, isTutor, emailVerified];
}
