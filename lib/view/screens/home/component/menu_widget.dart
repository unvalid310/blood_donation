import 'package:blood_donation/utill/images.dart';
import 'package:blood_donation/utill/routes.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.SYARAT_SCREEN);
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: Image.asset(
                          Images.ic_syarat_donor,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Syarat\n Donor',
                        textAlign: TextAlign.center,
                        style: interMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4.h),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.PENDAFTARAN_SCREEN);
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: Image.asset(
                          Images.ic_syarat_pendaftaran,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Formulir\n Pendaftaran',
                        textAlign: TextAlign.center,
                        style: interMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.PERMINTAAN_SCREEN);
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: Image.asset(
                          Images.ic_permintaan_darah,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Permintaan\n Darah',
                        textAlign: TextAlign.center,
                        style: interMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4.h),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.KETERSEDIAAN_SCREEN);
                  },
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: Image.asset(
                          Images.ic_ketersediaan_darah,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Ketersediaan\n Darah',
                        textAlign: TextAlign.center,
                        style: interMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
