import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/appointment/cubit/appointment_cubit.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/features/appointment/validator/appointment_validator.dart';
import 'package:hospital_app/features/appointment/view/date_view.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_box_decoration.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/constants/product_dropdown_decoration.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/lottie_loading.dart';
import 'package:kartal/kartal.dart';

import '../../../product/constants/product_strings.dart';

class DoctorView extends StatefulWidget {
  const DoctorView(
      {super.key, required this.polycilinicId, required this.hospitalId});

  final int polycilinicId;
  final int hospitalId;

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  String? _selectedValueDoctor;

  GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(AppointmentService(), context)
        ..fetchDoctors(widget.hospitalId, widget.polycilinicId),
      child: Scaffold(
        appBar: _buildCustomAppBar(),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return const LottieLoading();
            } else {
              return Padding(
                padding: const ProductPaddings.bodyPadding(),
                child: _buildDoctorSelectForm(context, state),
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
                title: Text(ProductStrings.instance.dViewAppBarText),
              ));
        },
      ),
    );
  }

  Widget _buildDoctorSelectForm(BuildContext context, AppointmentState state) {
    return Form(
      key: _dropdownFormKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: ProductBoxDecoration.patientContainerBDecoration(context),
        child: Column(children: [
          _buildContentExplanation(context),
          Padding(
            padding: const ProductPaddings.txtFormFieldPadding(),
            child: _buildDoctorDDButton(state),
          ),
          Padding(
            padding: const ProductPaddings.txtFormFieldPadding(),
            child: ContinueButton(
              onPressed: () {
                if (_dropdownFormKey.currentState!.validate()) {
                  context.route.navigateToPage(
                      DateView(
                        doctorId: int.parse(_selectedValueDoctor ?? "0"),
                      ),
                      type: SlideType.LEFT);
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildDoctorDDButton(AppointmentState state) {
    return DropdownButtonFormField(
      decoration:
          const ProducDropDownDecoration.appointmentDropDownDecoration(),
      items: state.doctors?.map((doctor) {
        return DropdownMenuItem(
            value: doctor.doktorId,
            child: Text("${doctor.doktorAdi} ${doctor.doktorSoyadi}"));
      }).toList(),
      value: _selectedValueDoctor,
      hint: Text(ProductStrings.instance.dViewDoctorDHintText),
      validator: (value) => AppointmentValidator.instance.doctorValidate(value),
      onChanged: (value) {
        setState(() {
          _selectedValueDoctor = value;
        });
      },
    );
  }

  Widget _buildContentExplanation(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const ProductBorderRadius.lTileContainerBRadius(),
          child: Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            fit: BoxFit.cover,
            ImagePaths.randevuDoktorlar.getImgPaths(),
          ),
        ),
        Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Card(
              elevation: 10,
              color: ProductColors.instance.mainRed,
              child: Padding(
                padding: const ProductPaddings.appointmentContentExpPadding(),
                child: Text(
                  textAlign: TextAlign.start,
                  ProductStrings.instance.dViewContentExpText,
                  style: context.general.textTheme.labelLarge,
                ),
              ),
            )),
        Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
                color: ProductColors.instance.mainRed,
                width: MediaQuery.of(context).size.width * 0.45,
                ImagePaths.logo.getLogoPaths()))
      ],
    );
  }
}
