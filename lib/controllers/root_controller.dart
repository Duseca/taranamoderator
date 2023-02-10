import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taranamoderator/utils/collection.dart';

class RootController extends GetxController with WidgetsBindingObserver {
  String? uid = Get.parameters["uid"];
  final box = GetStorage();
  Map roles = {};
  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    roles = box.read("roles") ?? {};
    activeUser();

    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void activeUser() async {
    await moderatorsCollection.doc(uid).update({
      "active": true,
    });
  }

  void deactiveUser() async {
    await moderatorsCollection.doc(uid).update({
      "active": false,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        activeUser();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        deactiveUser();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
