// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'appointment_cubit.dart';

class AppointmentState extends Equatable {
  const AppointmentState(
      {this.hospitals,
      this.polyclinics,
      this.doctors,
      this.patientId,
      this.appointmentResultInformationModel,
      this.dates,
      this.times,
      this.isLoading});

  final List<HospitalModel>? hospitals;
  final List<PolyclinicModel>? polyclinics;
  final List<DoctorModel>? doctors;
  final List<DateModel>? dates;
  final List<TimeModel>? times;
  final AppointmentResultInformationModel? appointmentResultInformationModel;
  final int? patientId;
  final bool? isLoading;

  @override
  List<Object?> get props => [
        hospitals,
        isLoading,
        polyclinics,
        doctors,
        appointmentResultInformationModel,
        patientId,
        times,
        dates
      ];

  AppointmentState copyWith(
      {List<HospitalModel>? hospitals,
      List<PolyclinicModel>? polyclinics,
      List<DoctorModel>? doctors,
      AppointmentResultInformationModel? appointmentResultInformationModel,
      bool? isLoading,
      int? patientId,
      List<DateModel>? dates,
      List<TimeModel>? times}) {
    return AppointmentState(
        hospitals: hospitals ?? this.hospitals,
        polyclinics: polyclinics ?? this.polyclinics,
        doctors: doctors ?? this.doctors,
        appointmentResultInformationModel: appointmentResultInformationModel ??
            this.appointmentResultInformationModel,
        patientId: patientId ?? this.patientId,
        isLoading: isLoading ?? this.isLoading,
        dates: dates ?? this.dates,
        times: times ?? this.times);
  }
}
