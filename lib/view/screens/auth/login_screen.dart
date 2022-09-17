import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation/provider/auth_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:blood_donation/view/base/custom_snackbar.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFD32F2F),
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 13.h, 4.h, 6.h),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'LOG IN',
                    style: interBold.copyWith(
                      fontSize: 28.sp,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Username / Email',
                    controller: _emailController,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Password',
                    isPassword: true,
                    isShowSuffixIcon: true,
                    controller: _passwordController,
                    isShowPrefixIcon: true,
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 2.h),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      child: Text(
                        "Lupa kata sandi?",
                        textAlign: TextAlign.left,
                        style: interRegular.copyWith(
                          fontSize: 10.sp,
                          color: ColorResources.COLOR_BLACK,
                        ),
                      ),
                      onTap: () {
                        print("I was tapped!");
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onTap: () {
                            context.loaderOverlay.show();
                            if (_formKey.currentState.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .login(
                                _emailController.text,
                                _passwordController.text,
                              )
                                  .then((isLogined) {
                                if (isLogined.isSuccess) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.HOME_SCREEN, (route) => false);
                                } else {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(
                                      isLogined.message, context);
                                }
                              });
                            } else {
                              context.loaderOverlay.hide();
                            }
                          },
                          label: 'LOG IN',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  RichText(
                    text: TextSpan(
                      text: "Belum punya akun? ",
                      style: interMedium.copyWith(
                        fontSize: 10.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                      children: [
                        TextSpan(
                          text: 'Daftar',
                          style: interRegular.copyWith(
                            fontSize: 10.sp,
                            color: Colors.blue[200],
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                  context,
                                  Routes.REGISTER_SCREEN,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
