import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference moderatorsCollection = FirebaseFirestore.instance.collection("moderators");
CollectionReference lyricsCollection = FirebaseFirestore.instance.collection("lyrics");