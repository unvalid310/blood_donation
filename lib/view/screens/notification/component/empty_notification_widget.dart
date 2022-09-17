import 'package:blood_donation/utill/images.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmptyNotificationWidget extends StatelessWidget {
  const EmptyNotificationWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.empty_data,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 2.h),
            Text(
              'Belum ada notifikasi nih\nCek lagi nanti ya...',
              textAlign: TextAlign.center,
              style: interMedium.copyWith(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
