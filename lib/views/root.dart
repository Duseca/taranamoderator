import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:taranamoderator/utils/collection.dart';
import 'package:taranamoderator/utils/common.dart';
import 'package:taranamoderator/views/add_lyrics.dart';
import 'package:taranamoderator/views/search.dart';

import '../controllers/root_controller.dart';
import 'tabs/songs_tab.dart';

class Root extends GetView<RootController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "Moderators",
          textAlign: TextAlign.center,
          shaderRect: const Rect.fromLTWH(10.0, 25.0, 50.0, 50.0),
          gradient: Gradients.cosmicFusion,
          style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (!controller.roles["canAddSongs"]) {
                customToast("No permission");
                return;
              }
              Get.to(() => AddLyrics(uid: controller.uid!));
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: ShapeDecoration(shape: const CircleBorder(), color: context.theme.primaryColor.withOpacity(0.05)),
              child: Icon(Icons.add, color: context.theme.primaryColor),
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => Search(uid: controller.uid!, roles: controller.roles)),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: ShapeDecoration(shape: const CircleBorder(), color: context.theme.primaryColor.withOpacity(0.05)),
              child: Icon(Icons.search, color: context.theme.primaryColor),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            StreamBuilder<DocumentSnapshot>(
                stream: moderatorsCollection.doc(controller.uid!).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  DocumentSnapshot udata = snapshot.data!;
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(side: BorderSide(color: Colors.grey)),
                      ),
                      child: udata["avatar"].isEmpty
                          ? Icon(LineAwesomeIcons.user, size: context.width / 6)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                udata["avatar"],
                                fit: BoxFit.cover,
                              )),
                    ),
                    accountName: Text(udata["username"], style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25)),
                    accountEmail: Text(udata["email"], style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black)),
                    decoration: BoxDecoration(color: Gradients.cosmicFusion.colors.first.withOpacity(0.05)),
                  );
                }),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed("/login");
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                decoration: ShapeDecoration(shape: const CircleBorder(), color: context.theme.primaryColor.withOpacity(0.05)),
                child: Icon(Icons.logout, color: context.theme.primaryColor),
              ),
              title: Text(
                "Logout",
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SongsTab(uid: controller.uid!, roles: controller.roles),
    );
  }
}
