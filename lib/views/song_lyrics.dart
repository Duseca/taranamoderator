import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/songlyrics_controller.dart';
import '../utils/collection.dart';

class SongLyrics extends GetView<SongLyricsController> {
  const SongLyrics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: GradientText(
            'Song Lyrics',
            textAlign: TextAlign.center,
            shaderRect: Rect.fromLTWH(10.0, 25.0, 50.0, 50.0),
            gradient: Gradients.cosmicFusion,
            style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.w700),
          ),

          bottom: TabBar(
            indicatorWeight: 0.001,
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Gradients.cosmicFusion.colors.first,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Farsi"),
              Tab(text: "English"),
            ],
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: lyricsCollection.doc(controller.lid!).snapshots(),
            builder: (context, lyricsSnapshot) {
              if (!lyricsSnapshot.hasData) return const Center(child: CircularProgressIndicator.adaptive());
              DocumentSnapshot lyricsData = lyricsSnapshot.data!;
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Gradients.cosmicFusion.colors.first.withOpacity(0.05),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text("آهنگ",
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                              subtitle: Text(
                                lyricsData["titleFarsi"],
                                textDirection: TextDirection.rtl,
                                style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            const Divider(color: Colors.white60),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("آواز خوان",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["artistFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("شاعر",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["poetFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("زبان",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["languageFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("آهنگساز",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["composerFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("تال",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["rhythmFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("راگ",
                                        textDirection: TextDirection.rtl,
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["ragFarsi"],
                                      textDirection: TextDirection.rtl,
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: context.width,
                        child: Text(
                          lyricsData["farsiLyrics"],
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.lato(fontSize: 17, color: Colors.black),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Gradients.cosmicFusion.colors.first.withOpacity(0.05),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                launchUrl(Uri.parse("https://www.youtu.be/RsVQS-kDZFQ"));
                              },
                              title: Text("لینک یوتیوب",
                                  textDirection: TextDirection.rtl,
                                  style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                              subtitle: Text(
                                "https://www.youtu.be/RsVQS-kDZFQ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Gradients.cosmicFusion.colors.first.withOpacity(0.05),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title:
                                  Text("Song Title", style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                              subtitle: Text(
                                lyricsData["title"],
                                style: GoogleFonts.lato(fontSize: 18, color: Colors.black),
                              ),
                            ),
                            const Divider(color: Colors.white60),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("Singer",
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["artist"],
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title:
                                        Text("Poet", style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["poet"],
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title:
                                    Text("Language", style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["language"],
                                      style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("Composer",
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["composer"],
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text("Rhythm",
                                        style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["rhythm"],
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title:
                                        Text("Rag", style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                                    subtitle: Text(
                                      lyricsData["rag"],
                                      style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: context.width,
                        child: Text(
                          lyricsData["englishLyrics"],
                          style: GoogleFonts.lato(fontSize: 17, color: Colors.black),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Gradients.cosmicFusion.colors.first.withOpacity(0.05),
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () {
                                launchUrl(Uri.parse("https://www.youtu.be/RsVQS-kDZFQ"));
                              },
                              title: Text("Youtube Link",
                                  style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                              subtitle: Text(
                                "https://www.youtu.be/RsVQS-kDZFQ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(fontSize: 15, color: Colors.black),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
