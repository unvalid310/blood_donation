// ignore_for_file: unnecessary_statements, must_be_immutable, camel_case_types

import 'package:blood_donation/helper/notification_helper.dart';
import 'package:blood_donation/main.dart';
import 'package:blood_donation/provider/permintaan_provider.dart';
import 'package:blood_donation/view/screens/home/component/checking_widget.dart';
import 'package:blood_donation/view/screens/home/component/header_widget.dart';
import 'package:blood_donation/view/screens/home/component/menu_widget.dart';
import 'package:blood_donation/view/screens/permintaan/daftar_permintaan_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int badge = 0;

  @override
  void initState() {
    super.initState();
    initNotification(context);
    // mengambil data permintaan
    Provider.of<PermintaanProvider>(context, listen: false).getPermintaan();
  }

  // fungsi listener notifikasi
  void initNotification(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Provider.of<PermintaanProvider>(context, listen: false).getPermintaan();
      setState(() {
        badge = 1;
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.data}");
      NotificationHelper.showNotification(
          message.data, flutterLocalNotificationsPlugin);
    });
  }

  void readNotif(int _badge) {
    setState(() {
      badge = _badge;
    });
  }

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
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 4.h),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(badge: badge, readNotif: readNotif),
                SizedBox(height: 4.h),
                MenuWidget(),
                SizedBox(height: 4.h),
                Consumer<PermintaanProvider>(
                    builder: (context, permintaan, child) {
                  if (permintaan.isLoading)
                    context.loaderOverlay.show();
                  else
                    context.loaderOverlay.hide();

                  return (permintaan.permintaanList != null)
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DaftarPermintaanScreen(
                                  permintaanList: permintaan.permintaanList,
                                ),
                              ),
                            );
                          },
                          child: CheckingWidget(
                            message: permintaan.messagePermintaan,
                          ),
                        )
                      : SizedBox();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
