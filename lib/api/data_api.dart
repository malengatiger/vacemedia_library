import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vacemedia_library/models/broadcaster.dart';
import 'package:vacemedia_library/models/live_show.dart';
import 'package:vacemedia_library/models/member.dart';
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

  static Future<bool> addLiveShowRegistration(
      {LiveShow liveShow, Member member}) async {
    var uuid = Uuid();
    LiveShowRegistration reg = LiveShowRegistration(
        registrationId: uuid.v4(),
        member: member,
        liveShow: liveShow,
        created: DateTime.now().toUtc().toIso8601String());

    var result =
        await firestore.collection(LIVESHOW_REGISTRATIONS).add(reg.toJson());
    p('🦠 🦠 🦠 LiveShowRegistration added to database : 🌼 ${result.path}');
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

  static Future<List<LiveShow>> getLiveShows(
      {@required DateTime laterThanDate}) async {
    List<LiveShow> list = [];
    QuerySnapshot qs;
    if (laterThanDate == null) {
      qs = await firestore.collection(LIVESHOWS).getDocuments();
    } else {
      qs = await firestore
          .collection(LIVESHOWS)
          .where('liveShow.endTime',
              isGreaterThan: laterThanDate.toUtc().toIso8601String())
          .getDocuments();
    }
    qs.documents.forEach((element) {
      var m = LiveShow.fromJson(element.data);
      list.add(m);
    });
    p('DatabaseAPI: getLiveShows: 🍐 🍐 🍐 LiveShows found 🍎 ${list.length} 🍎 ');
    return list;
  }

  static Future<List<LiveShow>> getBroadcasterLiveShows(
      {@required String broadcasterId, DateTime laterThanDate}) async {
    List<LiveShow> list = [];
    QuerySnapshot qs;
    if (laterThanDate == null) {
      qs = await firestore
          .collection(LIVESHOWS)
          .where('broadcaster.broadcasterId', isEqualTo: broadcasterId)
          .getDocuments();
    } else {
      qs = await firestore
          .collection(LIVESHOWS)
          .where('broadcaster.broadcasterId', isEqualTo: broadcasterId)
          .where('liveShow.endTime',
              isGreaterThan: laterThanDate.toUtc().toIso8601String())
          .getDocuments();
    }
    qs.documents.forEach((element) {
      var m = LiveShow.fromJson(element.data);
      list.add(m);
    });
    p('DatabaseAPI: 🍐 🍐 🍐 LiveShows found 🍎 ${list.length} 🍎 for $broadcasterId');
    return list;
  }

  static Future<List<LiveShowRegistration>> getLiveShowRegistrations(
      {@required String broadcasterId, DateTime laterThanDate}) async {
    List<LiveShowRegistration> list = [];
    QuerySnapshot qs;
    if (laterThanDate == null) {
      qs = await firestore
          .collection(LIVESHOW_REGISTRATIONS)
          .where('liveShow.broadcaster.broadcasterId', isEqualTo: broadcasterId)
          .getDocuments();
    } else {
      qs = await firestore
          .collection(LIVESHOW_REGISTRATIONS)
          .where('liveShow.broadcaster.broadcasterId', isEqualTo: broadcasterId)
          .where('liveShow.created',
              isGreaterThan: laterThanDate.toUtc().toIso8601String())
          .getDocuments();
    }
    qs.documents.forEach((element) {
      var m = LiveShowRegistration.fromJson(element.data);
      list.add(m);
    });
    p('DatabaseAPI: 🍐 🍐 🍐 LiveShowRegistrations found 🍎 ${list.length} 🍎');
    return list;
  }

  static Future<List<Broadcaster>> getBroadcasters() async {
    List<Broadcaster> list = [];
    QuerySnapshot qs;

    qs =
        await firestore.collection(BROADCASTERS).orderBy('name').getDocuments();

    qs.documents.forEach((element) {
      var m = Broadcaster.fromJson(element.data);
      list.add(m);
    });
    p('DatabaseAPI: 🍐 🍐 🍐 Broadcasters found 🍎 ${list.length} 🍎');
    return list;
  }
}
