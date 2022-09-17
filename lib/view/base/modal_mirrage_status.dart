import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ModalMirrageStatus extends StatelessWidget {
  const ModalMirrageStatus();

  @override
  Widget build(BuildContext context) {
    List status = ['Menikah', 'Belum Menikah'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: status.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, status[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    status[index],
                    style: interRegular.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
