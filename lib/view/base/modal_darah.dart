import 'package:blood_donation/data/model/response/darah_model.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ModalDarah extends StatelessWidget {
  final List<DarahModel> darahList;
  ModalDarah({@required this.darahList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
              itemCount: darahList.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1.h);
              },
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, {
                      "id": darahList[index].id,
                      "darah": darahList[index].darah,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: Text(
                      darahList[index].darah,
                      style: interRegular.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
