class Broadcaster {
  String broadcasterId, name;
  String created;

  Broadcaster({this.broadcasterId, this.name, this.created});

  Broadcaster.fromJson(Map data) {
    this.broadcasterId = data['broadcasterId'];
    this.name = data['name'];
    this.created = data['created'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['broadcasterId'] = broadcasterId;
    map['name'] = name;
    map['created'] = created;

    return map;
  }
}
