import 'package:cloud_firestore/cloud_firestore.dart';

class Generator {
  static Firestore firestore = Firestore.instance;

  static Future generate() async {
    _generateBroadcasters();
    _generateAudience();
    _generateLiveShows();
  }

  static Future _generateBroadcasters() async {}
  static Future _generateAudience() async {}
  static Future _generateLiveShows() async {}
}
