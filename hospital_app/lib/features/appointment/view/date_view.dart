import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/appointment/cubit/appointment_cubit.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/features/appointment/view/time_view.dart';
import 'package:hospital_app/product/constants/product_box_decoration.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/mixin/show_bottom_sheet.dart';
import 'package:hospital_app/product/widgets/lottie_loading.dart';
import 'package:kartal/kartal.dart';

class DateView extends StatelessWidget with ShowBottomSheet {
  const DateView({super.key, required this.doctorId});

  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppointmentCubit(AppointmentService(), context)..getDates(doctorId),
      child: Scaffold(
        appBar: _buildCustomAppBar(),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return const LottieLoading();
            } else {
              return Padding(
                padding: const ProductPaddings.bodyPadding(),
                child: _buildDates(state),
              );
            }
          },
        ),
      ),
    );
  }

  PreferredSize _buildCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {
          return WillPopScope(
              onWillPop: () async {
                if (state.isLoading == true) {
                  return false;
                } else {
                  return true;
                }
              },
              child: AppBar(
                title: Text(ProductStrings.instance.dtViewAppBarText),
              ));
        },
      ),
    );
  }

  Widget _buildDates(AppointmentState state) {
    return ListView.builder(
      itemCount: state.dates?.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const ProductPaddings.homeLTileContainerPadding(),
          decoration: ProductBoxDecoration.patientContainerBDecoration(context),
          child: ListTile(
            onTap: () {
              showCustomSheet(
                  context,
                  TimeView(
                      doctorId: doctorId,
                      date: state.dates?[index].calismaTarihi ?? ""));
            },
            leading: const Icon(Icons.date_range),
            trailing: const Icon(Icons.keyboard_arrow_down_outlined),
            title: Text(
              state.dates?[index].calismaTarihi ?? "",
              style: context.general.textTheme.titleMedium,
            ),
            contentPadding:
                const ProductPaddings.dateLTContainerContentPadding(),
          ),
        );
      },
    );
  }
}
