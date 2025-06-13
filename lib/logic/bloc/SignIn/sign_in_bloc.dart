import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/Routers/app_route_constants.dart';
import 'package:partner/core/Utils/pref_res.dart';
import 'package:partner/core/constant/Dialog/Common_dialog.dart';

import 'package:partner/core/constant/global.dart';
import 'package:partner/core/constant/loading.dart';
import 'package:partner/data/repositories/Auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GlobalKey<FormState> logInKey = GlobalKey<FormState>();
  SignInBloc() : super(SignInState()) {
    on<companyIdEvent>(companyId);
    on<emailIdEvent>(emailId);
    on<passwordEvent>(password);
    on<LoginEvent>(login);
  }

  FutureOr<void> companyId(companyIdEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(companyId: event.companyId));
  }

  FutureOr<void> emailId(emailIdEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(emailId: event.emailId));
  }

  FutureOr<void> password(passwordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> login(LoginEvent event, Emitter<SignInState> emit) async {
    try {
      Loading().showloading(event.context);
      var result = await AuthRepo.login(param: {
        "Email": state.emailId,
        "Password": state.password,
      });

      if (result.status == true) {
        Global.storageServices.setString(PrefConst.deviceToken, "true");
        Loading().dismissloading(event.context);

        GoRouter.of(event.context)
            .pushNamed(MyAppRouteConstants.dashBoardScreen);
      } else if (result.status == false) {
        Loading().dismissloading(event.context);

        CommonDialog.errorMessage(result.message);
      }
    } catch (e) {
      Loading().dismissloading(event.context);
      CommonDialog.errorMessage(e.toString());
    }
  }
}
