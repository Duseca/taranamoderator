import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taranamoderator/utils/common.dart';

import '../utils/collection.dart';
import '../views/approval.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  TextEditingController emailController = TextEditingController(), passwordController = TextEditingController();

  void emailLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async {
        String uid = value.user!.uid;

        DocumentSnapshot snapshot = await moderatorsCollection.doc(uid).get();

        if (!snapshot["approved"]) {
          Get.offAll(() => Approval(uid: uid));
          return;
        }

        box.write("roles", snapshot["roles"]);
        Get.offAllNamed("/root", parameters: {"uid": uid});
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          customToast("Account does not exists");
          break;
        case "wrong-password":
          customToast("Password is incorrect");
          break;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
