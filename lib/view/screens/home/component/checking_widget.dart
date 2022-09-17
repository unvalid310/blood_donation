import 'package:blood_donation/utill/images.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckingWidget extends StatelessWidget {
  final String message;
  CheckingWidget({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 2.h),
      decoration: BoxDecoration(
        color: Color(0xFFEB4335),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Cek Pengajuanmu',
                    style: interMedium.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Sedang dalam proses nih...',
                    style: interRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Image.asset(
              Images.on_checking,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
