import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/appointment/cubit/appointment_cubit.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/features/home/view/home_view.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/lottie_loading.dart';
import 'package:kartal/kartal.dart';

class AppointmentResultInformationView extends StatelessWidget with ShowLottie {
  const AppointmentResultInformationView(
      {super.key,
      required this.doctorId,
      required this.patientId,
      required this.date,
      required this.time});

  final int doctorId;
  final int patientId;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(AppointmentService(), context)
        ..getAppointmentResult(doctorId, patientId, date, time),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            ProductStrings.instance.ariViewAppBarText,
          ),
        ),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return const LottieLoading();
            } else {
              return Padding(
                padding: const ProductPaddings.bodyPadding(),
                child: Column(
                  children: [
                    _buildSuccessCard(context),
                    Padding(
                      padding:
                          const ProductPaddings.homeLTileContainerPadding(),
                      child: _buildPatientInfoCard(context, state),
                    ),
                    Padding(
                      padding:
                          const ProductPaddings.homeLTileContainerPadding(),
                      child: _buildAppointmentInfoCard(context, state),
                    ),
                    Padding(
                      padding:
                          const ProductPaddings.homeLTileContainerPadding(),
                      child: ContinueButton(
                        onPressed: () async {
                          showLottie(context);
                          await Future.delayed(const Duration(seconds: 1));
                          if (context.mounted) {
                            Navigator.pop(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeView(),
                                ),
                                (route) => false);
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentInfoCard(
      BuildContext context, AppointmentState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        elevation: 10,
        color: ProductColors.instance.seconRed,
        child: Padding(
          padding: const ProductPaddings.dateLTContainerContentPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ProductStrings.instance.ariViewAppointmentInfoHeader,
                  style: context.general.textTheme.titleLarge),
              Padding(
                padding: const ProductPaddings.appointmentContentExpPadding(),
                child: _buildAppointmentInfoText(context, state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentInfoText(
      BuildContext context, AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText1,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.doktorAdi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText2,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.doktorSoyadi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText3,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.hastaneAdi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText4,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.polikilinikAdi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText5,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.randevuSaati,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewAppointmentInfoText6,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.randevuTarihi,
                  style: context.general.textTheme.bodyMedium)
            ])),
      ],
    );
  }

  Widget _buildPatientInfoCard(BuildContext context, AppointmentState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        color: ProductColors.instance.seconRed,
        elevation: 10,
        child: Padding(
          padding: const ProductPaddings.dateLTContainerContentPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ProductStrings.instance.ariViewPatientInfoHeader,
                  style: context.general.textTheme.titleLarge),
              Padding(
                padding: const ProductPaddings.appointmentContentExpPadding(),
                child: _buildPatientInfoText(context, state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoText(BuildContext context, AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewPatientInfoText1,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.hastaAdi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewPatientInfoText2,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.hastaSoyadi,
                  style: context.general.textTheme.bodyMedium)
            ])),
        Text.rich(TextSpan(
            text: ProductStrings.instance.ariViewPatientInfoText3,
            style: context.general.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: state.appointmentResultInformationModel?.hastaTC,
                  style: context.general.textTheme.bodyMedium)
            ])),
      ],
    );
  }

  Widget _buildSuccessCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: Card(
        elevation: 10,
        color: ProductColors.instance.successGreen,
        child: Padding(
          padding: const ProductPaddings.dateLTContainerContentPadding(),
          child: Text(
            ProductStrings.instance.ariViewSuccessText,
            style: context.general.textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}
