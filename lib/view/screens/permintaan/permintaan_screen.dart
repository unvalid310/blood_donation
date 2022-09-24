// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:blood_donation/provider/darah_provider.dart';
import 'package:blood_donation/provider/permintaan_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/strings.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:blood_donation/view/base/custom_snackbar.dart';
import 'package:blood_donation/view/base/modal_darah.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PermintaanScreen extends StatelessWidget {
  PermintaanScreen();
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaOS = TextEditingController();
  TextEditingController rsDirawat = TextEditingController();
  TextEditingController golonganDarah = TextEditingController();
  TextEditingController macamDonor = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  String golonganDarahId;
  String tanggalValue;

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
              child: Column(
                children: [
                  CustomField(
                    hintText: 'Nama OS',
                    controller: namaOS,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 2.h),
                  CustomField(
                    hintText: 'RS Dirawat',
                    controller: rsDirawat,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.name,
                  ),
                  SizedBox(height: 2.h),
                  CustomField(
                    hintText: 'Macam Donor',
                    controller: macamDonor,
                    isShowPrefixIcon: true,
                  ),
                  SizedBox(height: 2.h),
                  CustomField(
                    hintText: 'Kapan Darah Dibutuhkan',
                    readOnly: true,
                    isShowPrefixIcon: true,
                    isShowSuffixIcon: true,
                    controller: tanggal,
                    isIcon: true,
                    suffixIcon: Icons.calendar_today_rounded,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime(DateTime.now().year + 10),
                      );

                      if (date != null) {
                        tanggal..text = getFormattedDate(date);
                        tanggalValue = getCustomDateFormat(date, 'yyyy-MM-dd');
                      }
                    },
                  ),
                  SizedBox(height: 2.h),
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
                  SizedBox(height: 2.h),
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
                    label: 'Ajukan',
                    onTap: () async {
                      // inisialisai data
                      final data = {
                        "nama_os": namaOS.text,
                        "rs_dirawat": rsDirawat.text,
                        "macam_donor": macamDonor.text,
                        "tanggal": tanggalValue,
                        "darah_id": golonganDarahId
                      };

                      // cek form validasi
                      if (_formKey.currentState.validate()) {
                        // post data to Api
                        Provider.of<PermintaanProvider>(context)
                            .createPermintaan(data)
                            .then((value) {
                          if (value.isSuccess) {
                            showCustomSnackBar(value.message, context,
                                isError: false);
                            Timer(
                              Duration(milliseconds: 510),
                              () => Navigator.pop(context),
                            );
                          } else {
                            showCustomSnackBar(value.message, context);
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
