import 'package:blood_donation/data/model/response/permintaan_model.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/screens/permintaan/detail_permintaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DaftarPermintaanScreen extends StatelessWidget {
  final List<PermintaanModel> permintaanList;
  DaftarPermintaanScreen({@required this.permintaanList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ColorResources.COLOR_BLACK,
        elevation: 0,
        title: Text(
          'Status Pengajuan',
          style: interBold.copyWith(fontSize: 14.sp),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
        child: ListView.separated(
          itemCount: permintaanList.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 2.h);
          },
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailPermintaanScreen(
                          id: permintaanList[index].id);
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      size: 35.sp,
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (permintaanList[index].status == 'true')
                              ? Text(
                                  'Pengajuanmu telah diproses\nSegera menuju kantor kami ya',
                                  style: interRegular.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                )
                              : (permintaanList[index].status == 'null')
                                  ? Text(
                                      'Pengajuanmu ditolak\nbuat pengajuan baru lagi ya',
                                      style: interRegular.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  : Text(
                                      'Pengajuanmu masih dalam proses\nNanti kita infokan kembali ya',
                                      style: interRegular.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
