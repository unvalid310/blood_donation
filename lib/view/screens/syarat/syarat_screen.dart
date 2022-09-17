import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class SyaratScreen extends StatelessWidget {
  const SyaratScreen();

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
        backgroundColor: Color(0xFFD32F2F),
        appBar: AppBar(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: ColorResources.COLOR_BLACK,
          elevation: 0,
          title: Text(
            'Syarat Donor',
            style: interBold.copyWith(fontSize: 14.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 2.h),
            color: Color(0xFFF5F5F5).withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '1.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Sehat jasmani dan rohani.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '2.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Usia 17 sampai dengan 65 tahun.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '3.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Berat badan minimal 45 kg.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '4.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Tekanan darah :\nsistole 100 - 170\ndiastole 70 - 100',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '5.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Kadar haemoglobin 12,5g% s/d 17,0g%.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '6.',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 0.5.h),
                    Expanded(
                      flex: 20,
                      child: Text(
                        'Interval donor minimal 12 minggu atau 3 bulan sejak donor darah sebelumnya (maksimal 5 kali dalam 2 tahun).',
                        style: interRegular.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
