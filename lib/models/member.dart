class Member {
  String memberId, name, email;
  String created;

  Member({this.memberId, this.name, this.created, this.email});

  Member.fromJson(Map data) {
    this.memberId = data['memberId'];
    this.name = data['name'];
    this.created = data['created'];
    this.email = data['email'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['memberId'] = memberId;
    map['name'] = name;
    map['created'] = created;
    map['email'] = email;

    return map;
  }
}
