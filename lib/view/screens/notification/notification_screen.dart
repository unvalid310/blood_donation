import 'package:blood_donation/provider/notification_provider.dart';
import 'package:blood_donation/utill/color_resources.dart';
import 'package:blood_donation/utill/styles.dart';
import 'package:blood_donation/view/screens/notification/component/empty_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen();

  @override
  Widget build(BuildContext context) {
    // memanggil data notifikasi
    Provider.of<NotificationProvider>(context, listen: false).getNotification();

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: ColorResources.COLOR_BLACK,
          elevation: 0,
          title: Text(
            'Notifikasi',
            style: interBold.copyWith(fontSize: 14.sp),
          ),
        ),
        body: Consumer<NotificationProvider>(
          builder: (context, notification, child) {
            if (notification.isLoading)
              context.loaderOverlay.show();
            else
              context.loaderOverlay.hide();
            print(
                'notification list >> ${notification.notificationList.length}');

            return (notification.notificationList != null)
                ? Container(
                    padding: EdgeInsets.fromLTRB(4.h, 2.h, 4.h, 6.h),
                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: notification.notificationList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 2.h);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                notification.notificationList[index].title,
                                style: interBold.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                notification.notificationList[index].message,
                                style: interRegular.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : EmptyNotificationWidget();
          },
        ),
      ),
    );
  }
}
