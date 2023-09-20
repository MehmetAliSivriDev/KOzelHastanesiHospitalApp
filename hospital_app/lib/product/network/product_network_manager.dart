class ProductNetworkManager {
  ProductNetworkManager._init();

  static ProductNetworkManager instance = ProductNetworkManager._init();

  final getDoctorsUri =
      Uri.parse('http://10.0.2.2/HospitalApp/get_doctors.php');

  final getDoctorsWithIDsUri =
      Uri.parse('http://10.0.2.2/HospitalApp/get_doctors_with_ids.php');

  final getPatientsUri =
      Uri.parse('http://10.0.2.2/HospitalApp/get_patients.php');

  final loginPatientUri = Uri.parse("http://10.0.2.2/HospitalApp/login.php");

  final getHospitalsUri =
      Uri.parse("http://10.0.2.2/HospitalApp/get_hospitals.php");

  final getPolyclinicsUri =
      Uri.parse("http://10.0.2.2/HospitalApp/get_polyclinics.php");

  final getDateUri = Uri.parse("http://10.0.2.2/HospitalApp/get_date.php");

  final getTimeUri = Uri.parse("http://10.0.2.2/HospitalApp/get_time.php");

  final takeAppointmentUri =
      Uri.parse("http://10.0.2.2/HospitalApp/take_appointment.php");

  final getAppointmentResultInfoUri = Uri.parse(
      "http://10.0.2.2/HospitalApp/appointment_result_information.php");

  final postPatientQuestionUri =
      Uri.parse("http://10.0.2.2/HospitalApp/patient_question.php");

  final getPatientMessagesUri =
      Uri.parse("http://10.0.2.2/HospitalApp/get_patient_messages.php");

  final updatePatientInfoUri =
      Uri.parse("http://10.0.2.2/HospitalApp/update_patient_info.php");

  final registerUri = Uri.parse("http://10.0.2.2/HospitalApp/register.php");

  final personalLoginUri =
      Uri.parse("http://10.0.2.2/HospitalApp/personal_login.php");

  final getPatientQuestionsWithPolyclinicUri = Uri.parse(
      "http://10.0.2.2/HospitalApp/get_questions_with_polyclinic.php");

  final postDoctorAnswerUri =
      Uri.parse("http://10.0.2.2/HospitalApp/doctor_answer.php");
}
