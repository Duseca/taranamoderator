import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:taranamoderator/utils/collection.dart';
import 'package:taranamoderator/utils/common.dart';

class AddLyrics extends StatefulWidget {
  final String uid;
  const AddLyrics({Key? key, required this.uid}) : super(key: key);

  @override
  State<AddLyrics> createState() => _AddLyricsState();
}

class _AddLyricsState extends State<AddLyrics> {
  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  int pageIndex = 0;

  final TextEditingController titleController = TextEditingController(),
      poetController = TextEditingController(),
      artistController = TextEditingController(),
      composerController = TextEditingController(),
      ragController = TextEditingController(),
      rhythmController = TextEditingController(),
      languageController = TextEditingController(),
      youtubeController = TextEditingController(),
      englishLyricsController = TextEditingController();

  final TextEditingController titleFarsiController = TextEditingController(),
      poetFarsiController = TextEditingController(),
      artistFarsiController = TextEditingController(),
      composerFarsiController = TextEditingController(),
      ragFarsiController = TextEditingController(),
      rhythmFarsiController = TextEditingController(),
      languageFarsiController = TextEditingController(),
      farsiLyricsController = TextEditingController();

  @override
  void dispose() {
    pageController.dispose();
    titleController.dispose();
    poetController.dispose();
    artistController.dispose();
    composerController.dispose();
    ragController.dispose();
    rhythmController.dispose();
    languageController.dispose();
    englishLyricsController.dispose();
    titleFarsiController.dispose();
    poetFarsiController.dispose();
    artistFarsiController.dispose();
    composerFarsiController.dispose();
    ragFarsiController.dispose();
    rhythmFarsiController.dispose();
    languageFarsiController.dispose();
    farsiLyricsController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'Add Lyrics',
          textAlign: TextAlign.center,
          shaderRect: const Rect.fromLTWH(10.0, 25.0, 50.0, 50.0),
          gradient: Gradients.cosmicFusion,
          style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndex = 0;
                      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    });
                  },
                  child: Container(
                    width: (context.width / 2) - 20,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: pageIndex == 0 ? Gradients.cosmicFusion.colors.first : null,
                    ),
                    alignment: Alignment.center,
                    child: Text("Farsi", style: GoogleFonts.lato(fontSize: 25, color: pageIndex == 0 ? Colors.white : Colors.black)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pageIndex = 1;
                      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    });
                  },
                  child: Container(
                    width: (context.width / 2) - 20,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: pageIndex == 1 ? Gradients.cosmicFusion.colors.last : null,
                    ),
                    alignment: Alignment.center,
                    child: Text("English", style: GoogleFonts.lato(fontSize: 25, color: pageIndex == 1 ? Colors.white : Colors.black)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  //farsi
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "آهنگ",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: titleFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "آواز خوان",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: artistFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "زبان",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: languageFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "شاعر",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: poetFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "آهنگساز",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: composerFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "راگ",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: ragFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "تال",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: rhythmFarsiController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "لینک یوتیوب",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: youtubeController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "زبان فارسی",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),

                      TextFormField(
                        controller: farsiLyricsController,
                        keyboardType: TextInputType.multiline,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        maxLines: 20,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                    ],
                  ),
                  //english
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Song Title",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Singer",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: artistController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Language",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: languageController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Poet",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: poetController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Composer",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: composerController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Rag",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: ragController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Rhythm",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: rhythmController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Youtube Link",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: youtubeController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          "Lyrics",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                        ),
                      ),
                      TextFormField(
                        controller: englishLyricsController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter here",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          hintStyle: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.grey)),
                          enabledBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.grey)),
                        ),
                        validator: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: context.theme.scaffoldBackgroundColor,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: GradientButton(
            callback: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              if ((titleController.text.isEmpty && titleFarsiController.text.isNotEmpty) ||
                  (titleController.text.isNotEmpty && titleFarsiController.text.isEmpty)) {
                customToast("Please upload title in both language");
                return;
              }

              if ((artistController.text.isEmpty && artistFarsiController.text.isNotEmpty) ||
                  (artistController.text.isNotEmpty && artistFarsiController.text.isEmpty)) {
                customToast("Please upload singer in both language");
                return;
              }

              if ((poetController.text.isEmpty && poetFarsiController.text.isNotEmpty) ||
                  (poetController.text.isNotEmpty && poetFarsiController.text.isEmpty)) {
                customToast("Please upload poet in both language");
                return;
              }

              if ((composerController.text.isEmpty && composerFarsiController.text.isNotEmpty) ||
                  (composerController.text.isNotEmpty && composerFarsiController.text.isEmpty)) {
                customToast("Please upload composer in both language");
                return;
              }

              if ((languageController.text.isEmpty && languageFarsiController.text.isNotEmpty) ||
                  (languageController.text.isNotEmpty && languageFarsiController.text.isEmpty)) {
                customToast("Please upload language in both language");
                return;
              }

              if ((ragController.text.isEmpty && ragFarsiController.text.isNotEmpty) ||
                  (ragController.text.isNotEmpty && ragFarsiController.text.isEmpty)) {
                customToast("Please upload rag in both language");
                return;
              }

              if ((rhythmController.text.isEmpty && rhythmFarsiController.text.isNotEmpty) ||
                  (rhythmController.text.isNotEmpty && rhythmFarsiController.text.isEmpty)) {
                customToast("Please upload rhythm in both language");
                return;
              }

              await lyricsCollection.add({
                "active": false,
                "addedOn": DateTime.now(),
                "adminID": widget.uid,
                "artist": artistController.text.isEmpty ? "Untitled" : artistController.text.trim(),
                "artistFarsi": artistFarsiController.text.isEmpty ? "Untitled" : artistFarsiController.text.trim(),
                "composer": composerController.text.isEmpty ? "Untitled" : composerController.text.trim(),
                "composerFarsi": composerFarsiController.text.isEmpty ? "Untitled" : composerFarsiController.text.trim(),
                "poet": poetController.text.isEmpty ? "Untitled" : poetController.text.trim(),
                "poetFarsi": poetFarsiController.text.isEmpty ? "Untitled" : poetFarsiController.text.trim(),
                "language": languageController.text.isEmpty ? "Untitled" : languageController.text.trim(),
                "languageFarsi": languageFarsiController.text.isEmpty ? "Untitled" : languageFarsiController.text.trim(),
                "rag": ragController.text.isEmpty ? "Untitled" : ragController.text.trim(),
                "ragFarsi": ragFarsiController.text.isEmpty ? "Untitled" : ragFarsiController.text.trim(),
                "rhythm": rhythmController.text.isEmpty ? "Untitled" : rhythmController.text.trim(),
                "rhythmFarsi": rhythmFarsiController.text.isEmpty ? "Untitled" : rhythmFarsiController.text.trim(),
                "title": titleController.text.isEmpty ? "Untitled" : titleController.text.trim(),
                "titleFarsi": titleFarsiController.text.isEmpty ? "Untitled" : titleFarsiController.text.trim(),
                "englishLyrics": englishLyricsController.text.isEmpty ? "Untitled" : englishLyricsController.text.trim(),
                "farsiLyrics": farsiLyricsController.text.isEmpty ? "Untitled" : farsiLyricsController.text.trim(),
                "youtubeURL": youtubeController.text,
                "popularity": 0,
              });

              await moderatorsCollection.doc(widget.uid).update({"lyricsAdded": FieldValue.increment(1)});

              customToast("Song added for review");
              Get.back();
            },
            increaseWidthBy: context.width,
            gradient: Gradients.cosmicFusion,
            increaseHeightBy: 10,
            child: Text('Add for review', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
