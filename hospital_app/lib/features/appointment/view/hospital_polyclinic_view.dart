import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/appointment/cubit/appointment_cubit.dart';
import 'package:hospital_app/features/appointment/service/appointment_service.dart';
import 'package:hospital_app/features/appointment/validator/appointment_validator.dart';
import 'package:hospital_app/features/appointment/view/doctor_view.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_box_decoration.dart';
import 'package:hospital_app/product/constants/product_colors.dart';
import 'package:hospital_app/product/constants/product_dropdown_decoration.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/mixin/show_lottie.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/lottie_loading.dart';
import 'package:kartal/kartal.dart';

class HospitalPolyclinicView extends StatefulWidget with ShowLottie {
  const HospitalPolyclinicView({super.key});

  @override
  State<HospitalPolyclinicView> createState() => _HospitalPolyclinicViewState();
}

class _HospitalPolyclinicViewState extends State<HospitalPolyclinicView> {
  String? _selectedValueHospital;
  String? _selectedValuePolyclinic;

  GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentCubit(AppointmentService(), context)
        ..fetchHospital()
        ..fetchPolyclinics(),
      child: Scaffold(
        appBar: _buildCustomAppBar(),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return const LottieLoading();
            } else {
              return Padding(
                padding: const ProductPaddings.bodyPadding(),
                child: _buildHPForm(context, state),
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
                title: Text(ProductStrings.instance.hpViewAppBarText),
              ));
        },
      ),
    );
  }

  Widget _buildHPForm(BuildContext context, AppointmentState state) {
    return Form(
        key: _dropdownFormKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: ProductBoxDecoration.patientContainerBDecoration(context),
          child: Column(
            children: [
              _buildContentExplanation(context),
              Padding(
                padding: const ProductPaddings.txtFormFieldPadding(),
                child: _buildHospitalDropDown(state),
              ),
              Padding(
                padding: const ProductPaddings.txtFormFieldPadding(),
                child: _buildPolycilinicDropDown(state),
              ),
              Padding(
                padding: const ProductPaddings.txtFormFieldPadding(),
                child: ContinueButton(
                  onPressed: () {
                    if (_dropdownFormKey.currentState!.validate()) {
                      context.route.navigateToPage(
                          DoctorView(
                              polycilinicId:
                                  int.parse(_selectedValuePolyclinic ?? "0"),
                              hospitalId:
                                  int.parse(_selectedValueHospital ?? "0")),
                          type: SlideType.LEFT);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildPolycilinicDropDown(AppointmentState state) {
    return DropdownButtonFormField(
      decoration:
          const ProducDropDownDecoration.appointmentDropDownDecoration(),
      hint: Text(ProductStrings.instance.hpViewPolycilinicDHintText),
      value: _selectedValuePolyclinic,
      items: state.polyclinics?.map((polyclinic) {
        return DropdownMenuItem(
            value: polyclinic.polikilinikId,
            child: Text(polyclinic.polikilinikAdi ?? ""));
      }).toList(),
      validator: (value) =>
          AppointmentValidator.instance.polyclinicValidate(value),
      onChanged: (value) {
        setState(() {
          _selectedValuePolyclinic = value;
        });
      },
    );
  }

  Widget _buildHospitalDropDown(AppointmentState state) {
    return DropdownButtonFormField(
      decoration:
          const ProducDropDownDecoration.appointmentDropDownDecoration(),
      hint: Text(ProductStrings.instance.hpViewHospitalDHintText),
      value: _selectedValueHospital,
      items: state.hospitals?.map((hospital) {
        return DropdownMenuItem(
            value: hospital.hastaneId, child: Text(hospital.hastaneAdi ?? ""));
      }).toList(),
      validator: (value) =>
          AppointmentValidator.instance.hospitalValidate(value),
      onChanged: (value) {
        setState(() {
          _selectedValueHospital = value;
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
            ImagePaths.uzmanlaraSorunDoktor.getImgPaths(),
          ),
        ),
        Positioned(
            left: 1,
            right: 1,
            bottom: 10,
            child: Card(
              elevation: 10,
              color: ProductColors.instance.mainRed,
              child: Padding(
                padding: const ProductPaddings.appointmentContentExpPadding(),
                child: Text(
                  textAlign: TextAlign.start,
                  ProductStrings.instance.hpViewContentExpText,
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
