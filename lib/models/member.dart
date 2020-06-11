class Member {
  String memberId, name;
  String created;

  Member({this.memberId, this.name, this.created});

  Member.fromJson(Map data) {
    this.memberId = data['memberId'];
    this.name = data['name'];
    this.created = data['created'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['memberId'] = memberId;
    map['name'] = name;
    map['created'] = created;

    return map;
  }
}
