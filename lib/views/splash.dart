import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../controllers/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: GradientText(
            'Tarana Lyrics',
            textAlign: TextAlign.center,
            //shaderRect: Rect.fromLTWH(150.0, 25.0, 50.0, 50.0),
            gradient: Gradients.cosmicFusion,
            style: GoogleFonts.theNautigal(fontSize: context.width / 5, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
