part of 'sign_in_bloc.dart';

class SignInState {

  final String emailId;
  final String password;

  SignInState({ this.password = "", this.emailId = ""});

  SignInState copyWith({
    String? companyId,
    String? emailId,
    String? password,
  }) {
    return SignInState(

        emailId: emailId ?? this.emailId,
        password: password ?? this.password);
  }
}
