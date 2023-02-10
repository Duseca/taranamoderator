import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:taranamoderator/utils/common.dart';
import 'package:taranamoderator/views/edit_lyrics.dart';

import '../../utils/collection.dart';

class SongsTab extends StatefulWidget {
  final String uid;
  final Map roles;
  const SongsTab({Key? key, required this.uid, required this.roles}) : super(key: key);

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {
  DocumentSnapshot? lastDoc;
  List prevDocIds = [];
  List<DocumentSnapshot> lyricsList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: lastDoc == null
                  ? lyricsCollection.orderBy("addedOn", descending: true).limit(15).snapshots()
                  : lyricsCollection
                      .orderBy("addedOn", descending: true)
                      .startAtDocument(lastDoc!)
                      .limit(15)
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator.adaptive());
                if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator.adaptive());
                lyricsList = snapshot.data!.docs;
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: lyricsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: lyricsList[index]["active"] ? Colors.white : Colors.red.shade50,
                      onTap: () => Get.toNamed("/song_lyrics", parameters: {"uid": widget.uid, "lid": lyricsList[index].id}),
                      leading: Icon(Icons.music_note, color: Gradients.cosmicFusion.colors.first),
                      minLeadingWidth: 0,
                      title: Text(
                        lyricsList[index]["title"],
                        maxLines: 2,
                        style: context.textTheme.bodyText1!.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        onPressed: () => openMoreSheet(lyricsList[index].id, lyricsList[index]["active"]),
                        icon: const Icon(Icons.more_vert),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white.withOpacity(0.2), height: 10),
                );
              }),
        ),
        Container(
          color: Colors.white,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              prevDocIds.isEmpty
                  ? const SizedBox.shrink()
                  : ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          lastDoc = prevDocIds.removeLast();
                        });
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 15),
                      style: ElevatedButton.styleFrom(primary: Gradients.cosmicFusion.colors.first, shape: const StadiumBorder()),
                      label: Text("Previous", style: GoogleFonts.lato(fontSize: 12, color: Colors.white)),
                    ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    prevDocIds.add(lyricsList.first);
                    lastDoc = lyricsList.last;
                  });
                },
                style: ElevatedButton.styleFrom(primary: Gradients.cosmicFusion.colors.last, shape: const StadiumBorder()),
                icon: Text("Next", style: GoogleFonts.lato(fontSize: 12, color: Colors.white)),
                label: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
              )
            ],
          ),
        )
      ],
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
