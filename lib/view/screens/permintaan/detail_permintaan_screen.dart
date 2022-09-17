// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:blood_donation/data/model/response/permintaan_model.dart';
import 'package:blood_donation/provider/darah_provider.dart';
import 'package:blood_donation/provider/permintaan_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/strings.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DetailPermintaanScreen extends StatelessWidget {
  final int id;
  DetailPermintaanScreen({@required this.id});
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaOS = TextEditingController();
  TextEditingController rsDirawat = TextEditingController();
  TextEditingController golonganDarah = TextEditingController();
  TextEditingController macamDonor = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  bool stokPengajuan = false;
  String rekomendasi = '';
  bool stokRekomendasi = false;

  void loadData(BuildContext context) async {
    await Provider.of<PermintaanProvider>(context, listen: false)
        .getDetailPermintaan(id);
  }

  @override
  Widget build(BuildContext context) {
    loadData(context);

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
            'Permintaan Darah',
            style: interBold.copyWith(fontSize: 14.sp),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Consumer<PermintaanProvider>(
                builder: (context, permintaan, child) {
                  if (permintaan.isLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }
                  if (permintaan.permintaanModel != null) {
                    namaOS.text = permintaan.permintaanModel.namaOs;
                    rsDirawat.text = permintaan.permintaanModel.rsDirawat;
                    golonganDarah.text =
                        permintaan.permintaanModel.pengajuanDarah;
                    macamDonor.text = permintaan.permintaanModel.macamDonor;
                    tanggal.text = getFormattedDate(
                        DateTime.parse(permintaan.permintaanModel.tanggal));
                    stokPengajuan = permintaan.permintaanModel.stokPengajuan;
                    stokRekomendasi =
                        permintaan.permintaanModel.stokRekomendasi;
                    rekomendasi = permintaan.permintaanModel.rekomendasiDarah;
                    print('tanggal >> ${tanggal.text}');
                  }

                  return Column(
                    children: [
                      CustomField(
                        hintText: 'Nama OS',
                        readOnly: true,
                        controller: namaOS,
                        isShowPrefixIcon: true,
                        inputType: TextInputType.name,
                      ),
                      SizedBox(height: 2.h),
                      CustomField(
                        hintText: 'RS Dirawat',
                        readOnly: true,
                        controller: rsDirawat,
                        isShowPrefixIcon: true,
                        inputType: TextInputType.name,
                      ),
                      SizedBox(height: 2.h),
                      CustomField(
                        hintText: 'Macam Donor',
                        controller: macamDonor,
                        readOnly: true,
                        isShowPrefixIcon: true,
                      ),
                      SizedBox(height: 2.h),
                      CustomField(
                        hintText: 'Kapan Darah Dibutuhkan',
                        controller: tanggal,
                        readOnly: true,
                        isShowPrefixIcon: true,
                        isShowSuffixIcon: true,
                        isIcon: true,
                        suffixIcon: Icons.calendar_today_rounded,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Darah yang diajukan',
                              style: interMedium.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  'Golongan Darah ${golonganDarah.text}',
                                  textAlign: TextAlign.center,
                                  style: interBold.copyWith(fontSize: 16.sp),
                                ),
                              ),
                            ),
                            SizedBox(width: 1.h),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 2.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: (stokPengajuan)
                                      ? Color(0xFF23C133).withOpacity(0.8)
                                      : Color(0xFF900E0E).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  (stokPengajuan) ? 'Ada' : 'TIdak Ada',
                                  textAlign: TextAlign.center,
                                  style: interMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: (stokPengajuan)
                                        ? ColorResources.COLOR_WHITE
                                        : ColorResources.COLOR_BLACK,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      (!stokPengajuan && rekomendasi != null && stokRekomendasi)
                          ? Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Maka bisa memakai darah',
                                    style: interMedium.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(height: 1.h),
                      (!stokPengajuan && rekomendasi != null && stokRekomendasi)
                          ? Container(
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Golongan Darah $rekomendasi',
                                        textAlign: TextAlign.center,
                                        style:
                                            interBold.copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 2.h),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (stokRekomendasi)
                                            ? Color(0xFF23C133).withOpacity(0.8)
                                            : Color(0xFF900E0E)
                                                .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        (stokRekomendasi) ? 'Ada' : 'Tidak Ada',
                                        textAlign: TextAlign.center,
                                        style: interMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: (stokRekomendasi)
                                              ? ColorResources.COLOR_WHITE
                                              : ColorResources.COLOR_BLACK,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
