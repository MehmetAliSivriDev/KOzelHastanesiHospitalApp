// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'personal_home_cubit.dart';

class PersonalHomeState extends Equatable {
  const PersonalHomeState(
      {this.doctorModel,
      this.email,
      this.polyclinics,
      this.isLoading,
      this.questions,
      this.doctorId});

  final String? email;
  final DoctorModel? doctorModel;
  final List<PolyclinicModel>? polyclinics;
  final List<PatientQuestionsModel>? questions;
  final bool? isLoading;
  final int? doctorId;

  @override
  List<Object?> get props =>
      [email, doctorModel, polyclinics, isLoading, questions, doctorId];

  PersonalHomeState copyWith(
      {String? email,
      DoctorModel? doctorModel,
      List<PolyclinicModel>? polyclinics,
      List<PatientQuestionsModel>? questions,
      bool? isLoading,
      int? doctorId}) {
    return PersonalHomeState(
        email: email ?? this.email,
        doctorModel: doctorModel ?? this.doctorModel,
        polyclinics: polyclinics ?? this.polyclinics,
        isLoading: isLoading ?? this.isLoading,
        questions: questions ?? this.questions,
        doctorId: doctorId ?? this.doctorId);
  }
}
