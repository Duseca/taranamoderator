import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taranamoderator/utils/collection.dart';
import 'package:taranamoderator/utils/common.dart';

import '../views/approval.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  void checkAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser == null ? "" : auth.currentUser!.uid;

    Future.delayed(const Duration(seconds: 1), () async {
      if (uid.isEmpty) {
        Get.offAllNamed("/login");
        return;
      }

      DocumentSnapshot snapshot = await moderatorsCollection.doc(uid).get();

      if (!snapshot["approved"]) {
        Get.offAll(() => Approval(uid: uid));
        return;
      }

      box.write("roles", snapshot["roles"]);
      Get.offAllNamed("/root", parameters: {"uid": uid});
    });
  }
}
