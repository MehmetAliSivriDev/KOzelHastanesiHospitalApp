import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/login/cubit/login_cubit.dart';
import 'package:hospital_app/features/login/service/login_service.dart';
import 'package:hospital_app/features/login/validator/login_validator.dart';
import 'package:hospital_app/product/constants/product_durations.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/widgets/buttons/continue_button.dart';
import 'package:hospital_app/product/widgets/buttons/divider_close_button.dart';
import 'package:hospital_app/product/widgets/text_form_field/email_text_form_field.dart';
import 'package:hospital_app/product/widgets/text_form_field/password_text_form_field.dart';
import 'package:kartal/kartal.dart';

// ignore: must_be_immutable
class PersonalLoginView extends StatelessWidget {
  PersonalLoginView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginService(), context),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const ProductPaddings.bodyPadding(),
            child: _buildPersonalLoginForm(context),
          );
        },
      ),
    );
  }

  Widget _buildPersonalLoginForm(BuildContext context) {
    return AnimatedSize(
      duration: ProductDurations.imageRowDuration,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: context.general.isKeyBoardOpen
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const DividerCloseButton(),
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildHeader(context),
              ),
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildEmailTFF(),
              ),
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildPasswordTFF(),
              ),
              Padding(
                padding: const ProductPaddings.pmCardPadding(),
                child: _buildLoginButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return AnimatedOpacity(
      duration: ProductDurations.imageRowDuration,
      opacity: context.general.isKeyBoardOpen ? 0 : 1,
      child: ContinueButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<LoginCubit>().fetchPersonalLogin(
                emailController.text, passwordController.text);
          }
        },
      ),
    );
  }

  Widget _buildPasswordTFF() {
    return PasswordTextFormField(
        passwordController: passwordController,
        validator: LoginValidator.instance
            .personalPassValidator(passwordController.text));
  }

  Widget _buildEmailTFF() {
    return EmailTextFormField(
        emailController: emailController,
        validator:
            LoginValidator.instance.emailController(emailController.text));
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      ProductStrings.instance.pLoginButtonText,
      style: context.general.textTheme.headlineMedium,
    );
  }
}
