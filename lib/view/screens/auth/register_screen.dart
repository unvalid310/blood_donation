import 'package:blood_donation/provider/auth_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:blood_donation/view/base/custom_snackbar.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    'REGISTER',
                    style: interBold.copyWith(
                      fontSize: 28.sp,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Username',
                    controller: _usernameController,
                    isShowPrefixIcon: true,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Email',
                    controller: _emailController,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Password',
                    isPassword: true,
                    isShowSuffixIcon: true,
                    controller: _passwordController,
                    isShowPrefixIcon: true,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Re-password',
                    isPassword: true,
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'REGISTER',
                          onTap: () async {
                            final Map<String, dynamic> data = {
                              "username": _usernameController.text,
                              "email": _emailController.text,
                              "password": _passwordController.text
                            };
                            context.loaderOverlay.show();
                            if (_formKey.currentState.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .registration(data)
                                  .then((value) {
                                if (value.isSuccess) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.LOGIN_SCREEN, (route) => false);
                                } else {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            } else {
                              context.loaderOverlay.hide();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  RichText(
                    text: TextSpan(
                      text: "Sudah punya akun?? ",
                      style: interMedium.copyWith(
                        fontSize: 10.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: interRegular.copyWith(
                            fontSize: 10.sp,
                            color: Colors.blue[200],
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, Routes.LOGIN_SCREEN),
                        )
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
