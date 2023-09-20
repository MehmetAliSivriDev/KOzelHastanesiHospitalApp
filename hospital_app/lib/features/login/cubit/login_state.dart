// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({this.loginModel, this.isLogin});

  final LoginModel? loginModel;
  final bool? isLogin;

  @override
  List<Object?> get props => [loginModel, isLogin];

  LoginState copyWith({
    LoginModel? loginModel,
    bool? isLogin,
  }) {
    return LoginState(
      loginModel: loginModel ?? this.loginModel,
      isLogin: isLogin ?? this.isLogin,
    );
  }
}
