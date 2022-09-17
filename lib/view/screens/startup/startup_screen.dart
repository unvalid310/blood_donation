import 'package:blood_donation/utill/images.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD32F2F),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(4.h, 20.h, 4.h, 6.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                Images.on_boarding,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 5.h),
            PrimaryButton(
              label: 'REGISTER',
              onTap: () {
                Navigator.pushNamed(context, Routes.REGISTER_SCREEN);
              },
            ),
            SizedBox(height: 2.h),
            PrimaryButton(
              label: 'LOG IN',
              onTap: () {
                Navigator.pushNamed(context, Routes.LOGIN_SCREEN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
