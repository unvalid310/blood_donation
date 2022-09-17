// ignore_for_file: must_be_immutable, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:badges/badges.dart';
import 'package:blood_donation/utill/app_constants.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:blood_donation/di_container.dart' as di;

class HeaderWidget extends StatelessWidget {
  final int badge;
  final Function(int) readNotif;
  HeaderWidget({this.badge, @required this.readNotif});
  final SharedPreferences _sharedPreferences = di.sl();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.PROFILE_SCREEN);
          },
          child: Icon(
            Icons.account_circle_outlined,
            size: 15.w,
          ),
        ),
        SizedBox(width: 1.h),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.PROFILE_SCREEN);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello,',
                  style: interBold.copyWith(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  _sharedPreferences.getString(AppConstants.USERNAME),
                  style: interRegular.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 1.h),
        Badge(
          showBadge: (badge > 0) ? true : false,
          position: BadgePosition.topEnd(top: 0, end: 3),
          animationDuration: Duration(milliseconds: 300),
          animationType: BadgeAnimationType.slide,
          child: InkWell(
            onTap: () {
              readNotif(0);
              Navigator.pushNamed(context, Routes.NOTIFICATION_SCREEN);
            },
            child: Icon(
              Icons.notifications_none_rounded,
              size: 10.w,
            ),
          ),
        )
      ],
    );
  }
}
