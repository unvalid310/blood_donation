import 'package:blood_donation/provider/auth_provider.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_snackbar.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:blood_donation/di_container.dart' as di;

class ProfileScreen extends StatelessWidget {
  ProfileScreen();
  final SharedPreferences _sharedPref = di.sl();

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: ColorResources.COLOR_BLACK,
          elevation: 0,
          title: Text(
            'Akun',
            style: interBold.copyWith(fontSize: 14.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 10.w,
                  ),
                  SizedBox(width: 1.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _sharedPref.getString(AppConstants.USERNAME),
                          style: interRegular.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Text(
                'Informasi Pribadi',
                style: interRegular.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Username',
                      style: interRegular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.h),
                  Text(
                    _sharedPref.getString(AppConstants.USERNAME),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interRegular.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Email',
                      style: interRegular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.h),
                  Text(
                    _sharedPref.getString(AppConstants.EMAIL),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: interRegular.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Password',
                      style: interRegular.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.h),
                  Text(
                    _sharedPref.getString(AppConstants.PASSWORD),
                    style: interRegular.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.h),
              PrimaryButton(
                label: 'Log Out',
                onTap: () async {
                  context.loaderOverlay.show();
                  await Provider.of<AuthProvider>(context, listen: false)
                      .logout()
                      .then(
                    (value) {
                      if (value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.LOGIN_SCREEN, (route) => false);
                      } else {
                        context.loaderOverlay.show();
                        showCustomSnackBar('Terjadi kesalahan', context);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
