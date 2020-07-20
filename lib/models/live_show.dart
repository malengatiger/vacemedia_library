import 'package:vacemedia_library/models/broadcaster.dart';
import 'package:vacemedia_library/models/member.dart';

class LiveShow {
  String liveShowId, name;
  String created, description;
  String startTime, endTime;
  Channel channel;

  LiveShow(
      {this.liveShowId,
      this.name,
      this.description,
      this.startTime,
      this.endTime,
      this.channel,
      this.created});

  LiveShow.fromJson(Map data) {
    this.liveShowId = data['liveShowId'];
    this.name = data['name'];
    this.description = data['description'];
    this.startTime = data['startTime'];
    this.endTime = data['endTime'];
    this.created = data['created'];
    if (data['channel'] != null) {
      this.channel = Channel.fromJson(data['channel']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['liveShowId'] = liveShowId;
    map['name'] = name;
    map['created'] = created;
    map['description'] = description;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['created'] = created;
    map['channel'] = channel == null ? null : channel.toJson();
    return map;
  }
}

class Channel {
  String channelId, name;
  String created, description;
  Broadcaster broadcaster;

  Channel(
      {this.channelId,
      this.name,
      this.description,
      this.broadcaster,
      this.created});

  Channel.fromJson(Map data) {
    this.channelId = data['channelId'];
    this.name = data['name'];
    this.description = data['description'];
    this.created = data['created'];
    if (data['broadcaster'] != null) {
      this.broadcaster = Broadcaster.fromJson(data['broadcaster']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['channelId'] = channelId;
    map['name'] = name;
    map['created'] = created;
    map['description'] = description;
    map['created'] = created;
    map['broadcaster'] = broadcaster == null ? null : broadcaster.toJson();
    return map;
  }
}

class LiveShowRegistration {
  String registrationId;
  String created;
  Member member;
  LiveShow liveShow;

  LiveShowRegistration(
      {this.registrationId, this.member, this.liveShow, this.created});

  LiveShowRegistration.fromJson(Map data) {
    this.registrationId = data['registrationId'];
    this.created = data['created'];

    if (data['member'] != null) {
      this.member = Member.fromJson(data['member']);
    }
    if (data['liveShow'] != null) {
      this.liveShow = LiveShow.fromJson(data['liveShow']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['registrationId'] = registrationId;
    map['created'] = created;
    map['member'] = member == null ? null : member.toJson();
    map['liveShow'] = liveShow == null ? null : liveShow.toJson();
    return map;
  }
}
