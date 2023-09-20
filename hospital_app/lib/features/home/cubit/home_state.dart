// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.email,
    this.patientModel,
    this.polyclinics,
    this.patientMessages,
  });

  final String? email;
  final PatientModel? patientModel;
  final List<PolyclinicModel>? polyclinics;
  final List<PatientMessageModel>? patientMessages;

  @override
  List<Object?> get props =>
      [email, patientModel, polyclinics, patientMessages];

  HomeState copyWith({
    String? email,
    PatientModel? patientModel,
    List<PolyclinicModel>? polyclinics,
    List<PatientMessageModel>? patientMessages,
  }) {
    return HomeState(
      email: email ?? this.email,
      patientModel: patientModel ?? this.patientModel,
      polyclinics: polyclinics ?? this.polyclinics,
      patientMessages: patientMessages ?? this.patientMessages,
    );
  }
}
