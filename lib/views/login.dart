import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../controllers/login_controller.dart';
import '../utils/form_validators.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

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
              shaderRect: Rect.fromLTWH(150.0, 25.0, 50.0, 50.0),
              gradient: Gradients.cosmicFusion,
              style: GoogleFonts.theNautigal(fontSize: context.width / 5, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 10),
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
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
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
                hintText: "Enter your password",
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintStyle: GoogleFonts.lato(fontSize: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
              ),
              validator: passwordValidator,
            ),
            const SizedBox(height: 30),
            GradientButton(
              callback: () => controller.emailLogin(),
              increaseWidthBy: context.width,
              gradient: Gradients.cosmicFusion,
              increaseHeightBy: 10,
              child:  Text('Login into account', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),

            const SizedBox(height: 30),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "Don't have an account?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed("/signup"),
                    child: Text(
                      "Sign up",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 18, color: Gradients.cosmicFusion.colors.first),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
