import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:vacemedia_library/models/broadcaster.dart';
import 'package:vacemedia_library/models/live_show.dart';
import 'package:vacemedia_library/models/member.dart';
import 'package:vacemedia_library/util/constants.dart';

import '../generic.dart';
import 'sharedprefs.dart';

class Auth {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;

  static Future<bool> userIsAuthenticated() async {
    var user = await firebaseAuth.currentUser();
    if (user == null) {
      p('🍅  🍅 User is NOT authenticated yet');
      return false;
    }
    p('🤟🏽  🤟🏽  🤟🏽 User is already authenticated');
    return true;
  }

  static Future<bool> signUp(
      {String name, String email, String password, String type}) async {
    if (type == BROADCASTERS) {
      var c = Broadcaster(name: name, email: email);
      await createBroadcaster(broadcaster: c, password: password);
      return true;
    }
    if (type == MEMBERS) {
      var c = Member(name: name, email: email);
      await createMember(member: c, password: password);
      return true;
    }
    throw Exception('Sign Up Failed');
  }

  static Future<bool> signIn({String email, String password}) async {
    var res = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    var mm = await firestore
        .collection('broadcasters')
        .where('broadcasterId', isEqualTo: res.user.uid)
        .limit(1)
        .getDocuments();
    if (mm.documents.isNotEmpty) {
      var caster = Broadcaster.fromJson(mm.documents.first.data);
      await Prefs.saveBroadcaster(caster);
      return true;
    }
    p('This user is not a Broadcaster');
    var mm2 = await firestore
        .collection('members')
        .where('broadcasterId', isEqualTo: res.user.uid)
        .limit(1)
        .getDocuments();
    if (mm2.documents.isNotEmpty) {
      var member = Member.fromJson(mm2.documents.first.data);
      await Prefs.saveMember(member);
      return true;
    }

    throw Exception('Sign In Failed');
  }

  static Future createBroadcaster(
      {Broadcaster broadcaster, String password}) async {
    p('️✳️✳️  Auth: createBroadcaster ... ${broadcaster.toJson()}');
    var fbUser = await createUser(email: broadcaster.email, password: password);
    broadcaster.broadcasterId = fbUser.uid;
    var res =
        await firestore.collection('broadcasters').add(broadcaster.toJson());
    p('🍐 🍐 🍐 ${res.path} 🍎 Broadcaster has been added to Firestore');
    Prefs.saveBroadcaster(broadcaster);

    var uuid = Uuid();
    var channel = Channel(
      name: broadcaster.name,
      channelId: uuid.v4(),
      broadcaster: broadcaster,
      created: DateTime.now().toUtc().toIso8601String(),
    );
    var result = await firestore.collection(CHANNELS).add(channel.toJson());
    p('🍐 🍐 🍐 ${result.path} 🍎 Broadcaster Default Channel has been added to Firestore');
    await Prefs.saveChannel(channel);
    return broadcaster;
  }

  static Future createMember({Member member, String password}) async {
    var fbUser = await createUser(email: member.email, password: password);
    member.memberId = fbUser.uid;
    var res = await firestore.collection('members').add(member.toJson());
    p('🍐 🍐 🍐 ${res.path} 🍎 Member has been added to Firestore');
    Prefs.saveMember(member);
    return null;
  }

  static Future<FirebaseUser> createUser(
      {String email, String password}) async {
    var result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null) {
      var mResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      p('🥡 🥡 🥡 ${mResult.user.email} has been signed in .... 🥬 🥬 🥬');
      return mResult.user;
    } else {
      throw Exception('User creation failed');
    }
  }
}
