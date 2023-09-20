import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/core/base/service/base_service.dart';
import 'package:hospital_app/features/home/cubit/home_cubit.dart';
import 'package:hospital_app/features/home/service/home_service.dart';
import 'package:hospital_app/features/home/validator/home_validator.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_dropdown_decoration.dart';
import 'package:hospital_app/product/constants/product_durations.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/buttons/divider_close_button.dart';
import 'package:kartal/kartal.dart';

class PatientQuestionView extends StatefulWidget {
  const PatientQuestionView({
    super.key,
  });

  @override
  State<PatientQuestionView> createState() => _PatientQuestionViewState();
}

class _PatientQuestionViewState extends State<PatientQuestionView> {
  String? _selectedValuePolyclinic;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(BaseService(), HomeService()),
      child: Padding(
        padding: const ProductPaddings.bodyPadding(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return _buildPatientQuestionForm(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildPatientQuestionForm(BuildContext context, HomeState state) {
    return Form(
      key: _formKey,
      child: AnimatedSize(
        duration: ProductDurations.passTxtFieldDuration,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: context.general.isKeyBoardOpen
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 0.65,
          child: Column(
            children: [
              const DividerCloseButton(),
              Text(ProductStrings.instance.pqViewHeaderText,
                  style: context.general.textTheme.titleLarge),
              Padding(
                padding: const ProductPaddings.homeLTileContainerPadding(),
                child: _buildPolyclinicDropDown(state),
              ),
              Padding(
                padding: const ProductPaddings.homeLTileContainerPadding(),
                child: _buildQuestionTextField(),
              ),
              AnimatedOpacity(
                opacity: context.general.isKeyBoardOpen ? 0 : 1,
                duration: ProductDurations.imageRowDuration,
                child: Padding(
                  padding: const ProductPaddings.pqViewButtonPadding(),
                  child: ContinueButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<HomeCubit>().postPatientQuestion(
                            state.email ?? "",
                            _selectedValuePolyclinic ?? "",
                            _questionController.text,
                            context);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionTextField() {
    return TextFormField(
      validator: (value) => HomeValidator.instance.questionValidate(value),
      controller: _questionController,
      maxLines: 4,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: ProductBorderRadius.dropdownBRadius()),
        hintText: ProductStrings.instance.pqViewQuestionTFText,
      ),
    );
  }

  Widget _buildPolyclinicDropDown(HomeState state) {
    return DropdownButtonFormField(
      decoration:
          const ProducDropDownDecoration.appointmentDropDownDecoration(),
      hint: Text(ProductStrings.instance.hpViewPolycilinicDHintText),
      value: _selectedValuePolyclinic,
      items: state.polyclinics?.map((polyclinic) {
        return DropdownMenuItem(
            value: polyclinic.polikilinikAdi,
            child: Text(polyclinic.polikilinikAdi ?? ""));
      }).toList(),
      validator: (value) => HomeValidator.instance.polyclinicValidate(value),
      onChanged: (value) {
        setState(() {
          _selectedValuePolyclinic = value;
        });
      },
    );
  }
}
