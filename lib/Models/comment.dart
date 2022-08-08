class Comment {
  String? fortuneTellerId;
  String? userid;
  double? point;
  String? comment;
  String? sId;
  String? sCreatedate;
  String? sUpdatedate;
  int? iV;

  Comment(
      {this.fortuneTellerId,
      this.userid,
      this.point,
      this.comment,
      this.sId,
      this.sCreatedate,
      this.sUpdatedate,
      this.iV});

  Comment.fromJson(Map<String, dynamic> json) {
    fortuneTellerId = json['fortuneTellerId'];
    userid = json['userid'];
    point = json['point'];
    comment = json['comment'];
    sId = json['_id'];
    sCreatedate = json['_createdate'];
    sUpdatedate = json['_updatedate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fortuneTellerId'] = fortuneTellerId;
    data['userid'] = userid;
    data['point'] = point;
    data['comment'] = comment;
    data['_id'] = sId;
    data['_createdate'] = sCreatedate;
    data['_updatedate'] = sUpdatedate;
    data['__v'] = iV;
    return data;
  }
}
