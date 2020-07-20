import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:vacemedia_library/models/live_show.dart';
import 'package:vacemedia_library/util/constants.dart';
import 'package:vacemedia_library/util/functions.dart';

class DatabaseAPI {
  static Firestore firestore = Firestore.instance;

  static Future<bool> addChannel({Channel channel}) async {
    var uuid = Uuid();
    channel.channelId = uuid.v4();
    var result = await firestore.collection(CHANNELS).add(channel.toJson());
    p('🦠 🦠 🦠 Channel added to database : 🌼 ${result.path}');
    return true;
  }

  static Future<bool> addLiveShow({LiveShow liveShow}) async {
    var uuid = Uuid();
    liveShow.liveShowId = uuid.v4();
    var result = await firestore.collection(LIVESHOWS).add(liveShow.toJson());
    p('🦠 🦠 🦠 LiveShow added to database : 🌼 ${result.path}');
    return true;
  }

  static Future<List<Channel>> getChannels({String broadcasterId}) async {
    var qs;
    if (broadcasterId == null) {
      qs = await firestore.collection(CHANNELS).getDocuments();
    } else {
      qs = await firestore
          .collection(CHANNELS)
          .where('broadcasterId', isEqualTo: broadcasterId)
          .getDocuments();
    }
    List<Channel> list = [];
    qs.documents.forEach((element) {
      var m = Channel.fromJson(element.data);
      list.add(m);
    });
    return list;
  }

  static Future<List<LiveShow>> getLiveShows({String broadcasterId}) async {
    var qs = await firestore
        .collection(LIVESHOWS)
        .where('broadcasterId', isEqualTo: broadcasterId)
        .getDocuments();
    List<LiveShow> list = [];
    qs.documents.forEach((element) {
      var m = LiveShow.fromJson(element.data);
      list.add(m);
    });
    return list;
  }
}
