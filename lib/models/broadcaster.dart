class Broadcaster {
  String broadcasterId, name, channelId, email;
  String created;

  Broadcaster(
      {this.broadcasterId,
      this.name,
      this.created,
      this.email,
      this.channelId});

  Broadcaster.fromJson(Map data) {
    this.broadcasterId = data['broadcasterId'];
    this.name = data['name'];
    this.email = data['email'];
    this.channelId = data['channelId'];
    this.created = data['created'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['broadcasterId'] = broadcasterId;
    map['name'] = name;
    map['created'] = created;
    map['channelId'] = channelId;
    map['email'] = email;

    return map;
  }
}

class BroadcasterProfile {
  String broadcasterId, description, imageURL;
  String videoURL;

  BroadcasterProfile(
      {this.broadcasterId, this.description, this.videoURL, this.imageURL});

  BroadcasterProfile.fromJson(Map data) {
    this.broadcasterId = data['broadcasterId'];
    this.description = data['description'];
    this.imageURL = data['imageURL'];
    this.videoURL = data['videoURL'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['broadcasterId'] = broadcasterId;
    map['description'] = description;
    map['videoURL'] = videoURL;
    map['imageURL'] = imageURL;

    return map;
  }
}
