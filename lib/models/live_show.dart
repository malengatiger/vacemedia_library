import 'package:vacemedia_library/models/broadcaster.dart';

class LiveShow {
  String liveShowId, name;
  String created, description;
  String startTime, endTime;
  Broadcaster broadcaster;

  LiveShow(
      {this.liveShowId,
      this.name,
      this.description,
      this.startTime,
      this.endTime,
      this.broadcaster,
      this.created});

  LiveShow.fromJson(Map data) {
    this.liveShowId = data['liveShowId'];
    this.name = data['name'];
    this.description = data['description'];
    this.startTime = data['startTime'];
    this.endTime = data['endTime'];
    this.created = data['created'];
    if (data['broadcaster'] != null) {
      this.broadcaster = Broadcaster.fromJson(data['broadcaster']);
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
    map['broadcaster'] = broadcaster == null ? null : broadcaster.toJson();
    return map;
  }
}
