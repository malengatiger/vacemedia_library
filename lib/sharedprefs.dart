import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vacemedia_library/models/broadcaster.dart';
import 'package:vacemedia_library/models/member.dart';

class Prefs {
  static Future saveBroadcaster(Broadcaster broadcaster) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map jsonx = broadcaster.toJson();
    var jx = json.encode(jsonx);
    prefs.setString('broadcaster', jx);
    print("🌽 🌽 🌽 Prefs.broadcaster  SAVED: 🌽 ${broadcaster.toJson()}");
    return null;
  }

  static void setThemeIndex(int index) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('index', index);
    print('🔵 🔵 🔵 Prefs: theme index set to: $index 🍎 🍎 ');
  }

  static Future<int> getThemeIndex() async {
    final preferences = await SharedPreferences.getInstance();
    var b = preferences.getInt('index');
    if (b == null) {
      return 0;
    } else {
      print('🔵 🔵 🔵  theme index retrieved: $b 🍏 🍏 ');
      return b;
    }
  }

  static Future<Broadcaster> getBroadcaster() async {
    var prefs = await SharedPreferences.getInstance();
    var string = prefs.getString('broadcaster');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var user = new Broadcaster.fromJson(jx);
    print("🌽 🌽 🌽 Prefs.geBroadcaster🧩  ${user.toJson()} retrieved");
    return user;
  }

  static Future saveMember(Member member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map jsonx = member.toJson();
    var jx = json.encode(jsonx);
    prefs.setString('member', jx);
    print(
        "🌽 🌽 🌽 Prefs.Member  SAVED: 🌽 ${member.toJson()}");
    return null;
  }

  static Future<Member> getMember() async {
    var prefs = await SharedPreferences.getInstance();
    var string = prefs.getString('member');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var member = new Member.fromJson(jx);
    print(
        "🌽 🌽 🌽 Prefs.getMember 🧩  ${member.toJson()} retrieved");
    return member;
  }

  static Future saveFCMToken(String token) async {
    print("SharedPrefs saving token ..........");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcm", token);
    //prefs.commit();

    print("FCM token saved in cache prefs: $token");
  }

  static Future<String> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("fcm");
    print("SharedPrefs - FCM token from prefs: $token");
    return token;
  }

  static Future saveMinutes(int minutes) async {
    print("SharedPrefs saving minutes ..........");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("minutes", minutes);

    print("FCM minutes saved in cache prefs: $minutes");
  }

  static Future<int> getMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var minutes = prefs.getInt("minutes");
    print("SharedPrefs - FCM minutes from prefs: $minutes");
    return minutes;
  }

  static void saveThemeIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("themeIndex", index);
    //prefs.commit();
  }

}
