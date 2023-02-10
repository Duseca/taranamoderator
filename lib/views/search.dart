import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../utils/collection.dart';
import '../utils/common.dart';
import 'edit_lyrics.dart';

class Search extends StatefulWidget {
  final String uid;
  final Map roles;
  const Search({Key? key, required this.uid, required this.roles}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  String searchText = "";
  bool inFarsi = true;
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          'Search',
          textAlign: TextAlign.center,
          shaderRect: const Rect.fromLTWH(10.0, 25.0, 50.0, 50.0),
          gradient: Gradients.cosmicFusion,
          style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: context.width,
            height: kToolbarHeight,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: Gradients.cosmicFusion,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.5),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                    textDirection: inFarsi ? TextDirection.rtl : TextDirection.ltr,
                    textAlign: inFarsi ? TextAlign.right : TextAlign.left,
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.change_circle),
                        color: Theme.of(context).primaryColor,
                        tooltip: "Change Language",
                        onPressed: () {
                          setState(() {
                            inFarsi = !inFarsi;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
                      hintText: "Search in ${inFarsi ? 'farsi' : 'english'}...",
                      hintStyle: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: searchText.isEmpty
                ? Center(
                    child: Image.asset("images/search_icon.png", width: context.width / 2),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: inFarsi
                        ? lyricsCollection.where("titleSearchFarsi", arrayContains: searchText).snapshots()
                        : lyricsCollection.where("titleSearch", arrayContains: searchText).snapshots(),
                    builder: (context, lSnapshot) {
                      if (!lSnapshot.hasData) return const Center(child: CircularProgressIndicator.adaptive());
                      List<DocumentSnapshot> lList = lSnapshot.data!.docs;
                      return ListView.builder(
                        itemCount: lList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            tileColor: lList[index]["active"] ? Colors.white : Colors.red.shade50,
                            onTap: () => Get.toNamed("/song_lyrics", parameters: {"uid": widget.uid, "lid": lList[index].id}),
                            leading: Icon(Icons.music_note, color: Gradients.cosmicFusion.colors.first),
                            title: Text(
                              lList[index]["title"],
                              maxLines: 2,
                              style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // if (lList[index]["adminID"] != widget.uid) {
                                //   customToast("No permission");
                                //   return;
                                // }
                                openMoreSheet(lList[index].id, lList[index]["active"]);
                              },
                              icon: const Icon(Icons.more_vert),
                            ),
                          );
                        },
                      );
                    }),
          ),
        ],
      ),
    );
  }

  void openMoreSheet(String lyricID, bool status) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                status ? "Active" : "Not Active",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: status ? Colors.green.shade700 : Colors.red.shade700),
              ),
            ),
            ListTile(
              onTap: () {
                if (!widget.roles["canEditSongs"]) {
                  customToast("No permission");
                  return;
                }
                Get.to(() => EditLyrics(uid: widget.uid, lid: lyricID));
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                decoration: ShapeDecoration(shape: const CircleBorder(), color: context.theme.primaryColor.withOpacity(0.05)),
                child: Icon(Icons.edit, color: context.theme.primaryColor),
              ),
              title: Text(
                "Edit Song",
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                if (!widget.roles["canDeleteSongs"]) {
                  customToast("No permission");
                  return;
                }
                Get.defaultDialog(
                  title: "Delete Song",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  content: Text("Are you sure you want to delete this song?",
                      textAlign: TextAlign.center, style: GoogleFonts.lato(color: Colors.grey.shade700)),
                  textConfirm: "Delete",
                  textCancel: "Cancel",
                  buttonColor: Gradients.cosmicFusion.colors.last,
                  cancelTextColor: Colors.grey.shade700,
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    await lyricsCollection.doc(lyricID).delete();

                    await moderatorsCollection.doc(widget.uid).update({"lyricsAdded": FieldValue.increment(-1)});
                    customToast("Song deleted");
                    Get.back();
                    Get.back();
                  },
                );
              },
              leading: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(right: 10),
                decoration: ShapeDecoration(shape: const CircleBorder(), color: context.theme.primaryColor.withOpacity(0.05)),
                child: Icon(Icons.delete, color: context.theme.primaryColor),
              ),
              title: Text(
                "Delete Song",
                style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
    );
  }
}
