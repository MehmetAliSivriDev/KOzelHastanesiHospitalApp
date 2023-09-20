import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_app/features/login/cubit/login_cubit.dart';
import 'package:hospital_app/features/login/service/login_service.dart';
import 'package:hospital_app/features/login/validator/login_validator.dart';
import 'package:hospital_app/features/login/view/personal_login_view.dart';
import 'package:hospital_app/features/register/view/register_view.dart';
import 'package:hospital_app/product/constants/product_button_styles.dart';
import 'package:hospital_app/product/constants/product_durations.dart';
import 'package:hospital_app/product/constants/product_paddings.dart';
import 'package:hospital_app/product/constants/product_strings.dart';
import 'package:hospital_app/product/extensions/image_paths.dart';
import 'package:hospital_app/product/mixin/show_bottom_sheet.dart';
import 'package:hospital_app/product/widgets/text_form_field/email_text_form_field.dart';
import 'package:hospital_app/product/widgets/text_form_field/password_text_form_field.dart';
import 'package:kartal/kartal.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget with ShowBottomSheet {
  LoginView({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginService(), context),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const ProductPaddings.pLButtonPadding(),
              child: _personalLoginButton(context),
            )
          ],
        ),
        body: Padding(
          padding: const ProductPaddings.bodyPadding(),
          child: _buildAuthForm(
              context, emailController, passwordController, formKey),
        ),
      ),
    );
  }

  Widget _buildAuthForm(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      Key key) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Form(
        key: key,
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              Padding(
                padding: const ProductPaddings.authImagePadding(),
                child: _buildImageRow(context),
              ),
              Padding(
                padding: const ProductPaddings.txtFormFieldPadding(),
                child: EmailTextFormField(
                  emailController: emailController,
                  validator: LoginValidator.instance
                      .emailController(emailController.text),
                ),
              ),
              Padding(
                padding: const ProductPaddings.txtFormFieldPadding(),
                child: PasswordTextFormField(
                    validator: LoginValidator.instance
                        .passwordValidator(passwordController.text),
                    passwordController: passwordController),
              ),
              Opacity(
                opacity: context.general.isKeyBoardOpen ? 0 : 1,
                child: _buildLRButtons(
                    context, emailController, passwordController),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLRButtons(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: context.general.isKeyBoardOpen
          ? 0
          : MediaQuery.of(context).size.height * 0.2,
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _loginButton(context, emailController, passwordController),
              _registerButton(context)
            ],
          );
        },
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return OutlinedButton(
        style: ProductButtonStyles.registerBStyle(),
        onPressed: () {
          context.route
              .navigateToPage(const RegisterView(), type: SlideType.TOP);
        },
        child: Text(ProductStrings.instance.registerButtonText,
            style: context.general.textTheme.titleMedium));
  }

  Widget _loginButton(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return FilledButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<LoginCubit>().fetchPatientLogin(
                emailController.text, passwordController.text);

            emailController.clear();
            passwordController.clear();
          }
        },
        child: Text(ProductStrings.instance.loginButtonText,
            style: context.general.textTheme.titleMedium));
  }

  Widget _personalLoginButton(BuildContext context) {
    return OutlinedButton(
        style: ProductButtonStyles.personalLoginBStyle(),
        onPressed: () {
          showCustomSheet(context, PersonalLoginView());
        },
        child: Text(ProductStrings.instance.pLoginButtonText,
            style: context.general.textTheme.titleSmall));
  }

  Widget _buildImageRow(BuildContext context) {
    return AnimatedSize(
      duration: ProductDurations.imageRowDuration,
      child: SizedBox(
        height: context.general.isKeyBoardOpen
            ? 0
            : MediaQuery.of(context).size.height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(ImagePaths.logo.getLogoPaths())),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(ImagePaths.bakanlikLogo.getLogoPaths()))
          ],
        ),
      ),
    );
  }
}
