import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taranamoderator/utils/collection.dart';
import 'package:taranamoderator/utils/common.dart';

import '../views/approval.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      nameController = TextEditingController();

  void createUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async {
        String uid = value.user!.uid;
        await moderatorsCollection.doc(uid).set({
          "email": emailController.text.toLowerCase(),
          "username": nameController.text,
          "avatar": "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_640.png",
          "approved": false,
          "active": false,
          "joined": DateTime.now(),
          "lyricsAdded": 0,
        });
        customToast("Account created successfully");
        Get.offAll(() => Approval(uid: uid));
      });
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          customToast("Email already in use");
          break;
        case "weak-password":
          customToast("Password is weak");
          break;
        case "invalid-email":
          customToast("Email format is invalid");
          break;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
