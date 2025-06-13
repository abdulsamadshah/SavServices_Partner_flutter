import 'dart:io';

import 'package:partner/core/Utils/app_res.dart';
import 'package:partner/core/Utils/color_res.dart';
import 'package:partner/core/common_widget/Inputfield.dart';
import 'package:partner/core/constant/appTheme.dart';
import 'package:partner/core/constant/validator.dart';

import 'package:partner/gen/fonts.gen.dart';
import 'package:partner/logic/bloc/SignIn/sign_in_bloc.dart';
import 'package:partner/presentation/common_widget/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/Dialog.dart';
import '../../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginBloc = SignInBloc();

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DialogBox.confirmationDialog(context,
            title: 'Are you sure you want to exit?',
            leftButtonOntap: () {
              Navigator.pop(context);
            },
            rightButtonOntap: () => exit(0));
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: 200.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.r),
                    color: ColorRes.lightOrange,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        reausabletext("Login",
                            color: ColorRes.white,
                            fontfamily: FontFamily.interBold,
                            fontsize: 30),
                        SizedBox(
                          height: 5.h,
                        ),
                        reausabletext("Welcome to ${AppRes.appName}",
                            color: ColorRes.white,
                            fontfamily: FontFamily.interRegular,
                            fontsize: 18)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 140.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorRes.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Form(
                      key: loginBloc.logInKey,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.w, top: 10.h, right: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            assetImage(Assets.images.appicon.path,
                                width: 250, height: 150),
                            SizedBox(
                              height: 50.h,
                            ),
                            title('Email Id'),
                            textfield(
                              context,
                              hintname: "Enter Email Id",
                              prefixicon: Icons.email,
                              onChanged: (value) {
                                loginBloc.add(emailIdEvent(value.toString()));
                              },
                              validator: Validator.validateEmail,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            title('Password'),
                            textfield(context,
                                hintname: "Enter Password",
                                prefixicon: Icons.lock, onChanged: (value) {
                              loginBloc.add(passwordEvent(value.toString()));
                            },
                                validator:
                                    Validator.validate(title: "Password")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
          child: reausablebuttons(
              title: "Login",
              ontap: () {
                if (loginBloc.logInKey.currentState!.validate()) {
                  loginBloc.add(LoginEvent(
                    context,
                  ));
                }
              }),
        ),
      ),
    );
  }


}
