class Fortuner {
  String? sId;
  String? sCreateuser;
  String? sUpdateuser;
  bool? bIsdeleted;
  int? iStatusid;
  String? userid;
  String? nickname;
  String? about;
  String? fortuneTellerStatus;
  String? channelId;
  bool? hasTarot;
  int? tarotServiceFee;
  bool? hasCoffee;
  int? coffeeServiceFee;
  bool? hasBirthChart;
  int? birthChartServiceFee;
  bool? hasAstrology;
  int? astrologyServiceFee;
  String? sCreatedate;
  String? sUpdatedate;
  int? iV;
  double? averagePoint;
  int? age;
  String? photo;
  String? status;

  Fortuner({
    this.sId,
    this.sCreateuser,
    this.sUpdateuser,
    this.bIsdeleted,
    this.iStatusid,
    this.userid,
    this.nickname,
    this.about,
    this.fortuneTellerStatus,
    this.channelId,
    this.hasTarot,
    this.tarotServiceFee,
    this.hasCoffee,
    this.coffeeServiceFee,
    this.hasBirthChart,
    this.birthChartServiceFee,
    this.hasAstrology,
    this.astrologyServiceFee,
    this.sCreatedate,
    this.sUpdatedate,
    this.iV,
    this.averagePoint,
    this.age,
    this.photo,
    this.status,
  });

  Fortuner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sCreateuser = json['_createuser'];
    sUpdateuser = json['_updateuser'];
    bIsdeleted = json['_isdeleted'];
    iStatusid = json['_statusid'];
    userid = json['userid'];
    nickname = json['nickname'];
    about = json['about'];
    fortuneTellerStatus = json['fortuneTellerStatus'];
    channelId = json['channelId'];
    hasTarot = json['hasTarot'];
    tarotServiceFee = json['tarotServiceFee'];
    hasCoffee = json['hasCoffee'];
    coffeeServiceFee = json['coffeeServiceFee'];
    hasBirthChart = json['hasBirthChart'];
    birthChartServiceFee = json['birthChartServiceFee'];
    hasAstrology = json['hasAstrology'];
    astrologyServiceFee = json['astrologyServiceFee'];
    sCreatedate = json['_createdate'];
    sUpdatedate = json['_updatedate'];
    iV = json['__v'];
    averagePoint = json['averagePoint']?.toDouble() ?? 0.0;
    age = json['age'];
    photo = json['userPhoto'];
    status = json['fortuneTellerStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['_createuser'] = sCreateuser;
    data['_updateuser'] = sUpdateuser;
    data['_isdeleted'] = bIsdeleted;
    data['_statusid'] = iStatusid;
    data['userid'] = userid;
    data['nickname'] = nickname;
    data['about'] = about;
    data['fortuneTellerStatus'] = fortuneTellerStatus;
    data['channelId'] = channelId;
    data['hasTarot'] = hasTarot;
    data['tarotServiceFee'] = tarotServiceFee;
    data['hasCoffee'] = hasCoffee;
    data['coffeeServiceFee'] = coffeeServiceFee;
    data['hasBirthChart'] = hasBirthChart;
    data['birthChartServiceFee'] = birthChartServiceFee;
    data['hasAstrology'] = hasAstrology;
    data['astrologyServiceFee'] = astrologyServiceFee;
    data['_createdate'] = sCreatedate;
    data['_updatedate'] = sUpdatedate;
    data['__v'] = iV;
    data['averagePoint'] = averagePoint?.toDouble() ?? 0;
    data['age'] = age;
    data['userPhoto'] = photo;
    data['fortuneTellerStatus'] = status;
    return data;
  }
}
