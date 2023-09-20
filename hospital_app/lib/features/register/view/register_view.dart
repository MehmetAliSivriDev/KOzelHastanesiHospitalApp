import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/login/validator/login_validator.dart';
import 'package:hospital_app/features/register/cubit/register_cubit.dart';
import 'package:hospital_app/features/register/model/register_model.dart';
import 'package:hospital_app/features/register/service/register_service.dart';
import 'package:hospital_app/features/register/validator/register_validator.dart';
import 'package:hospital_app/product/constants/product_border_radius.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/info_card.dart';
import 'package:hospital_app/product/widgets/text_form_field/email_text_form_field.dart';
import 'package:hospital_app/product/widgets/text_form_field/password_text_form_field.dart';
import 'package:hospital_app/product/widgets/text_form_field/simple_custom_text_form_field.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _identityController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();

  String? _selectedValueBlood;
  String? _selectedValueGender;

  final List<String> _bloods = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "0+",
    "0-"
  ];
  final List<String> _genders = ["Erkek", "Kız"];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(RegisterService(), context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(ProductStrings.instance.rwAppBarText),
        ),
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: const ProductPaddings.bodyPadding(),
              child: _buildRegisterForm(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const ProductPaddings.infoCardPadding(),
              child: InfoCard(text: ProductStrings.instance.upiViewInfoText),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildFirstNameTFF(),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildLastNameTFF(),
            ),
            Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildEmailTFF()),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildIdentityTFF(),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildPasswordTFF(),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildBirthDateTFF(context),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildBloodDDB(),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: _buildGenderDDB(),
            ),
            Padding(
              padding: const ProductPaddings.pmCardPadding(),
              child: ContinueButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_selectedValueGender == "Erkek") {
                      _selectedValueGender = "0";
                    } else if (_selectedValueGender == "Kız") {
                      _selectedValueGender = "1";
                    }
                    var model = RegisterModel(
                      hastaAdi: _firstNameController.text,
                      hastaSoyadi: _lastNameController.text,
                      hastaTC: _identityController.text,
                      hastaEposta: _emailController.text,
                      hastaSifre: _passwordController.text,
                      dogumTarihi: _birthDateController.text,
                      cinsiyet: _selectedValueGender,
                      kan: _selectedValueBlood,
                    );

                    context.read<RegisterCubit>().register(model);
                  }
                },
              ),
            ),
            _buildLogos(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLogos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          ImagePaths.logo.getLogoPaths(),
          width: MediaQuery.of(context).size.width * 0.6,
        ),
        Image.asset(
          ImagePaths.bakanlikLogo.getLogoPaths(),
          width: MediaQuery.of(context).size.width * 0.3,
        ),
      ],
    );
  }

  Widget _buildGenderDDB() {
    return DropdownButtonFormField(
      validator: (value) => RegisterValidator.instance.genderValidate(value),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: ProductBorderRadius.txtFormFieldBRadius()),
        hintText: ProductStrings.instance.rwGenderHintText,
      ),
      value: _selectedValueGender,
      items: _genders.map((gender) {
        return DropdownMenuItem(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValueGender = value;
        });
      },
    );
  }

  Widget _buildBloodDDB() {
    return DropdownButtonFormField(
      validator: (value) => RegisterValidator.instance.bloodValidate(value),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: ProductBorderRadius.txtFormFieldBRadius()),
        hintText: ProductStrings.instance.rwBloodHintText,
      ),
      value: _selectedValueBlood,
      items: _bloods.map((blood) {
        return DropdownMenuItem(value: blood, child: Text(blood));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValueBlood = value;
        });
      },
    );
  }

  Widget _buildBirthDateTFF(BuildContext context) {
    return TextFormField(
      validator: (value) => RegisterValidator.instance
          .birthDateController(_birthDateController.text),
      controller: _birthDateController,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.calendar_today),
        border: const OutlineInputBorder(
            borderRadius: ProductBorderRadius.txtFormFieldBRadius()),
        hintText: ProductStrings.instance.rwBirthDateHintText,
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _birthDateController.text = formattedDate;
          });
        } else {}
      },
    );
  }

  Widget _buildPasswordTFF() {
    return PasswordTextFormField(
        validator:
            LoginValidator.instance.passwordValidator(_passwordController.text),
        passwordController: _passwordController);
  }

  Widget _buildIdentityTFF() {
    return SimpleCustomTextFormField(
      controller: _identityController,
      hintText: ProductStrings.instance.rwIdentityHintText,
      validator: RegisterValidator.instance
          .identityController(_identityController.text),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildEmailTFF() {
    return EmailTextFormField(
        emailController: _emailController,
        validator:
            LoginValidator.instance.emailController(_emailController.text));
  }

  Widget _buildLastNameTFF() {
    return SimpleCustomTextFormField(
        controller: _lastNameController,
        hintText: ProductStrings.instance.rwLNHintText,
        validator: RegisterValidator.instance
            .lastNameValidator(_lastNameController.text));
  }

  Widget _buildFirstNameTFF() {
    return SimpleCustomTextFormField(
      controller: _firstNameController,
      hintText: ProductStrings.instance.rwFNHintText,
      validator: RegisterValidator.instance
          .firstNameController(_firstNameController.text),
    );
  }
}
