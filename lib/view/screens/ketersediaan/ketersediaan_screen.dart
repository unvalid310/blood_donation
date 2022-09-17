// ignore_for_file: must_be_immutable

import 'package:blood_donation/provider/darah_provider.dart';
import 'package:blood_donation/provider/ketersediaan_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:blood_donation/view/base/modal_darah.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class KetersediaanScreen extends StatelessWidget {
  KetersediaanScreen();
  TextEditingController golonganDarah = TextEditingController();
  String golonganDarahId;

  @override
  Widget build(BuildContext context) {
    golonganDarahId = '';

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
            'Ketersediaan Darah',
            style: interBold.copyWith(fontSize: 14.sp),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomField(
                  hintText: 'Golongan Darah',
                  controller: golonganDarah,
                  readOnly: true,
                  isShowPrefixIcon: true,
                  isShowSuffixIcon: true,
                  isIcon: true,
                  suffixIcon: Icons.arrow_drop_down_rounded,
                  onTap: () async {
                    final darah = await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        Provider.of<DarahProvider>(context, listen: false)
                            .getDarah();

                        return Consumer<DarahProvider>(
                          builder: (context, darah, child) {
                            print('golongan darah >> ${darah.darahList}');
                            return (darah.darahList != null)
                                ? ModalDarah(darahList: darah.darahList)
                                : Container();
                          },
                        );
                      },
                    );

                    if (darah != null) {
                      golonganDarah..text = darah['darah'];
                      golonganDarahId = darah['id'];
                    }
                  },
                ),
                SizedBox(height: 4.h),
                PrimaryButton(
                  label: 'Cek Ketersediaan',
                  onTap: () async {
                    // melakukan validasi inputan
                    if (golonganDarah.text.isNotEmpty)
                      // melakukan pencarian berdasarkan api
                      Provider.of<KetersediaanProvider>(context, listen: false)
                          .getKetersediaan(int.parse(golonganDarahId));
                  },
                ),
                SizedBox(height: 5.h),
                Consumer<KetersediaanProvider>(
                    builder: (context, ketersediaan, shild) {
                  if (ketersediaan.isLoading)
                    context.loaderOverlay.show();
                  else
                    context.loaderOverlay.hide();
                  print(
                      'stok rekomendasi => ${ketersediaan.pengajuanDarah.toString()}');

                  return (golonganDarah.text.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Darah yang dicari',
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
                                        color: (ketersediaan.stokPengajuan)
                                            ? Color(0xFF23C133).withOpacity(0.8)
                                            : Color(0xFF900E0E)
                                                .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        (ketersediaan.stokPengajuan)
                                            ? 'Ada'
                                            : 'TIdak Ada',
                                        textAlign: TextAlign.center,
                                        style: interMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: (ketersediaan.stokPengajuan)
                                              ? ColorResources.COLOR_WHITE
                                              : ColorResources.COLOR_BLACK,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            (ketersediaan.rekomendasiDarah != null &&
                                    !ketersediaan.stokPengajuan)
                                ? Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            (ketersediaan.rekomendasiDarah != null &&
                                    !ketersediaan.stokPengajuan)
                                ? Container(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Golongan Darah ${ketersediaan.rekomendasiDarah}',
                                              textAlign: TextAlign.center,
                                              style: interBold.copyWith(
                                                  fontSize: 16.sp),
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
                                              color:
                                                  (ketersediaan.stokRekomendasi)
                                                      ? Color(0xFF23C133)
                                                          .withOpacity(0.8)
                                                      : Color(0xFF900E0E)
                                                          .withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              (ketersediaan.stokRekomendasi)
                                                  ? 'Ada'
                                                  : 'Tidak Ada',
                                              textAlign: TextAlign.center,
                                              style: interMedium.copyWith(
                                                fontSize: 12.sp,
                                                color: (ketersediaan
                                                        .stokRekomendasi)
                                                    ? ColorResources.COLOR_WHITE
                                                    : ColorResources
                                                        .COLOR_BLACK,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        )
                      : SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
