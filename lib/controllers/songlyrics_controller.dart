import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SongLyricsController extends GetxController {
  String? uid = Get.parameters["uid"], lid = Get.parameters["lid"];
  RxBool isFav = false.obs;
  @override
  void onInit() {
    super.onInit();
  }


  openMoreOptions() {
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {},
                title: Text(
                  "Share song",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                ),
              ),
              const Divider(color: Colors.white60),
              ListTile(
                onTap: () async {},
                title: Text(
                  "Report song",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                ),
              ),
              const Divider(color: Colors.white60),
              ListTile(
                onTap: () async {},
                title: Text(
                  "Suggest a correction",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
  }
}
