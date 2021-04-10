import 'package:get/get.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';

class NotificationController extends GetxController {
  Rx<List<NotificationModel>> notificationList = Rx<List<NotificationModel>>();
  final _method = FireStoreMethod();

  @override
  void onInit() {
    notificationList.bindStream(_method.getNotification());

    super.onInit();
  }
}
