import 'package:flutter/material.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:sizer/sizer.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  const PrimaryButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5).withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: interBold.copyWith(
            fontSize: 14.sp,
            color: ColorResources.COLOR_BLACK,
          ),
        ),
      ),
    );
  }
}
