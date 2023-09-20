import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/appointment/cubit/appointment_cubit.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/product/constants/product_button_styles.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/widgets/buttons/divider_close_button.dart';
import 'package:kartal/kartal.dart';

class TimeView extends StatelessWidget {
  const TimeView({super.key, required this.doctorId, required this.date});

  final int doctorId;
  final String date;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppointmentCubit(AppointmentService(), context)
          ..getPatientId()
          ..getTimes(doctorId, date),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              const DividerCloseButton(),
              Text(ProductStrings.instance.tViewHeaderText,
                  style: context.general.textTheme.titleLarge),
              Expanded(
                child: BlocBuilder<AppointmentCubit, AppointmentState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const ProductPaddings.appointmetTimesPadding(),
                      child: _buildAppointmentTimes(state),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildAppointmentTimes(AppointmentState state) {
    return GridView.builder(
      itemCount: state.times?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 15, crossAxisCount: 3, mainAxisSpacing: 15),
      itemBuilder: (context, index) {
        return FilledButton(
            onPressed: (int.parse(state.times?[index].doluMu ?? "0")) == 0
                ? null
                : () {
                    AlertDialog alertDialog =
                        _buildTakeAppointmentAlertDialog(context, state, index);

                    showDialog(context: context, builder: (_) => alertDialog);
                  },
            child: Text(state.times?[index].calismaSaati ?? "",
                style: context.general.textTheme.titleMedium));
      },
    );
  }

  AlertDialog _buildTakeAppointmentAlertDialog(
      BuildContext context, AppointmentState state, int index) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(ProductStrings.instance.tViewADTitleText),
      content: _buildAlertDialogContent(context, state, index),
      actions: [
        _buildCancelButton(context),
        _buildTakeAppointmentButton(context, state, index),
      ],
    );
    return alertDialog;
  }

  Widget _buildCancelButton(BuildContext context) {
    return OutlinedButton(
        style: ProductButtonStyles.registerBStyle(),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(ProductStrings.instance.tViewADCancelButtonText,
            style: context.general.textTheme.titleMedium));
  }

  Widget _buildTakeAppointmentButton(
      BuildContext context, AppointmentState state, int index) {
    return FilledButton(
        onPressed: () async {
          final response = await context
              .read<AppointmentCubit>()
              .takeAppointment(doctorId, state.patientId ?? 0, date,
                  state.times?[index].calismaSaati ?? "");
          if (context.mounted) {
            context.read<AppointmentCubit>().checkAndNavigateForAppointment(
                response ?? 0,
                doctorId,
                date,
                state.times?[index].calismaSaati ?? "");
          }
        },
        child: Text(ProductStrings.instance.tViewADtAppoinmentBText,
            style: context.general.textTheme.titleMedium));
  }

  Widget _buildAlertDialogContent(
      BuildContext context, AppointmentState state, int index) {
    return Text.rich(TextSpan(
        text: date,
        style: context.general.textTheme.titleMedium,
        children: [
          TextSpan(
            text: ProductStrings.instance.tViewADContentText1,
            style: context.general.textTheme.labelLarge,
          ),
          TextSpan(
              text: state.times?[index].calismaSaati,
              style: context.general.textTheme.titleMedium),
          TextSpan(
            text: ProductStrings.instance.tViewADContentText2,
            style: context.general.textTheme.labelLarge,
          )
        ]));
  }
}
