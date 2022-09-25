class Conversation {
  String? sCreateuser;
  String? sUpdateuser;
  bool? bIsdeleted;
  int? iStatusid;
  String? fortuneTellerId;
  String? userid;
  String? agoraToken;
  String? conversationType;
  String? photo1;
  String? photo2;
  String? photo3;
  String? status;
  String? sId;
  String? sCreatedate;
  String? sUpdatedate;
  int? iV;
  int? agoraTokenuid;

  Conversation(
      {this.sCreateuser,
      this.sUpdateuser,
      this.bIsdeleted,
      this.iStatusid,
      this.fortuneTellerId,
      this.userid,
      this.agoraToken,
      this.conversationType,
      this.photo1,
      this.photo2,
      this.photo3,
      this.status,
      this.sId,
      this.sCreatedate,
      this.sUpdatedate,
      this.iV,
      this.agoraTokenuid,
      });

  Conversation.fromJson(Map<String, dynamic> json) {
    sCreateuser = json['_createuser'];
    sUpdateuser = json['_updateuser'];
    bIsdeleted = json['_isdeleted'];
    iStatusid = json['_statusid'];
    fortuneTellerId = json['fortuneTellerId'];
    userid = json['userid'];
    agoraToken = json['agoraToken'];
    conversationType = json['conversationType'];
    photo1 = json['photo1'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    status = json['status'];
    sId = json['_id'];
    sCreatedate = json['_createdate'];
    sUpdatedate = json['_updatedate'];
    iV = json['__v'];
    agoraTokenuid = json['agoraTokenUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_createuser'] = sCreateuser;
    data['_updateuser'] = sUpdateuser;
    data['_isdeleted'] = bIsdeleted;
    data['_statusid'] = iStatusid;
    data['fortuneTellerId'] = fortuneTellerId;
    data['userid'] = userid;
    data['agoraToken'] = agoraToken;
    data['conversationType'] = conversationType;
    data['photo1'] = photo1;
    data['photo2'] = photo2;
    data['photo3'] = photo3;
    data['status'] = status;
    data['_id'] = sId;
    data['_createdate'] = sCreatedate;
    data['_updatedate'] = sUpdatedate;
    data['__v'] = iV;
    data['agoraTokenUid'] = agoraTokenuid;
    return data;
  }
}
