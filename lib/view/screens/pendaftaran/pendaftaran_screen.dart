// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:blood_donation/provider/pendaftaran_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/strings.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/base/custom_field.dart';
import 'package:blood_donation/view/base/custom_snackbar.dart';
import 'package:blood_donation/view/base/modal_gender.dart';
import 'package:blood_donation/view/base/modal_mirrage_status.dart';
import 'package:blood_donation/view/base/primary_button.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PendaftaranScreen extends StatelessWidget {
  PendaftaranScreen();
  final _formKey = GlobalKey<FormState>();
  TextEditingController instansi = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController pekerjaan = TextEditingController();
  TextEditingController statusNikah = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController jenisDonor = TextEditingController();
  TextEditingController donorKe = TextEditingController();
  String tanggalLahirValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<PendaftaranProvider>(
        builder: (context, pendaftaran, child) {
      if (pendaftaran.isLoading)
        context.loaderOverlay.show();
      else
        context.loaderOverlay.hide();

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
              'Formulir Pendaftaran',
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
                      hintText: 'Nama Instansi',
                      controller: instansi,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Nama',
                      controller: nama,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Jenis Kelamin',
                      controller: jenisKelamin,
                      readOnly: true,
                      isShowPrefixIcon: true,
                      isShowSuffixIcon: true,
                      isIcon: true,
                      suffixIcon: Icons.arrow_drop_down_rounded,
                      onTap: () async {
                        final gender = await showModalBottomSheet(
                          context: context,
                          builder: (context) => ModalGender(),
                        );
                        if (gender != null) jenisKelamin..text = gender;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Tanggal Lahir',
                      controller: tanggalLahir,
                      readOnly: true,
                      isShowPrefixIcon: true,
                      isShowSuffixIcon: true,
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
                          tanggalLahir..text = getFormattedDate(date);
                          tanggalLahirValue =
                              getCustomDateFormat(date, 'yyyy-MM-dd');
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Pekerjaan',
                      controller: pekerjaan,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Status Nikah',
                      controller: statusNikah,
                      readOnly: true,
                      isShowPrefixIcon: true,
                      isShowSuffixIcon: true,
                      isIcon: true,
                      suffixIcon: Icons.arrow_drop_down_rounded,
                      onTap: () async {
                        final status = await showModalBottomSheet(
                          context: context,
                          builder: (context) => ModalMirrageStatus(),
                        );

                        if (status != null) statusNikah..text = status;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'No. Handphone',
                      controller: noTelp,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.phone,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Alamat',
                      controller: alamat,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Jenis Donor',
                      controller: jenisDonor,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 2.h),
                    CustomField(
                      hintText: 'Donor Ke-',
                      controller: donorKe,
                      isShowPrefixIcon: true,
                      inputType: TextInputType.number,
                    ),
                    SizedBox(height: 4.h),
                    PrimaryButton(
                      label: 'Daftar',
                      onTap: () {
                        // inisialisai data
                        final data = {
                          "instansi": instansi.text,
                          "nama": nama.text,
                          "jenis_kelamin": jenisKelamin.text,
                          "tanggal_lahir": tanggalLahirValue,
                          "pekerjaan": pekerjaan.text,
                          "status_nikah": statusNikah.text,
                          "no_telp": noTelp.text,
                          "alamat": alamat.text,
                          "jenis_donor": jenisDonor.text,
                          "donor_ke": donorKe.text
                        };

                        // cek form validasi
                        if (_formKey.currentState.validate()) {
                          // post data to Api
                          Provider.of<PendaftaranProvider>(context,
                                  listen: false)
                              .createPendaftaran(data)
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
    });
  }
}
