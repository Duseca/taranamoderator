import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../controllers/signup_controller.dart';
import '../utils/form_validators.dart';

class Signup extends GetView<SignupController> {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          children: [
            GradientText(
              'Tarana Lyrics',
              textAlign: TextAlign.center,
              shaderRect: const Rect.fromLTWH(150.0, 25.0, 50.0, 50.0),
              gradient: Gradients.cosmicFusion,
              style: GoogleFonts.theNautigal(fontSize: context.width / 5, fontWeight: FontWeight.w700),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: context.width / 3,
              width: context.width / 3,
              decoration: const ShapeDecoration(
                shape: CircleBorder(side: BorderSide(color: Colors.grey)),
              ),
              child: Icon(LineAwesomeIcons.user, size: context.width / 6),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                "Username",
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: controller.nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              style: GoogleFonts.lato(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Your username",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintStyle: GoogleFonts.lato(fontSize: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
              ),
              validator: nameValidator,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                "Email Address",
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: GoogleFonts.lato(fontSize: 14),
              decoration: InputDecoration(
                hintText: "Enter an email address",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintStyle: GoogleFonts.lato(fontSize: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
              ),
              validator: emailValidator,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                "Password",
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              style: GoogleFonts.lato(fontSize: 14),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Create your password",
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintStyle: GoogleFonts.lato(fontSize: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
              ),
              validator: passwordValidator,
            ),
            const SizedBox(height: 30),
            GradientButton(
              callback: () => controller.createUser(),
              increaseWidthBy: context.width,
              gradient: Gradients.cosmicFusion,
              increaseHeightBy: 10,
              child: Text('Create new account', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "Already have an account?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 18, color: Gradients.cosmicFusion.colors.first),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
