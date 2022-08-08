class User {
  String? sCreateuser;
  String? sUpdateuser;
  bool? bIsdeleted;
  int? iStatusid;
  String? name;
  String? lastname;
  String? password;
  String? email;
  String? birthday;
  String? gender;
  String? sId;
  String? sCreatedate;
  String? sUpdatedate;
  int? iV;
  String? zodiac;

  User(
      {this.sCreateuser,
      this.sUpdateuser,
      this.bIsdeleted,
      this.iStatusid,
      this.name,
      this.lastname,
      this.password,
      this.email,
      this.birthday,
      this.gender,
      this.sId,
      this.sCreatedate,
      this.sUpdatedate,
      this.iV,
      this.zodiac,
      });

  User.fromJson(Map<String, dynamic> json) {
    sCreateuser = json['_createuser'];
    sUpdateuser = json['_updateuser'];
    bIsdeleted = json['_isdeleted'];
    iStatusid = json['_statusid'];
    name = json['name'];
    lastname = json['lastname'];
    password = json['password'];
    email = json['email'];
    birthday = json['birthday'];
    gender = json['gender'];
    sId = json['_id'];
    sCreatedate = json['_createdate'];
    sUpdatedate = json['_updatedate'];
    iV = json['__v'];
    zodiac = json["zodiacSign"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_createuser'] = sCreateuser;
    data['_updateuser'] = sUpdateuser;
    data['_isdeleted'] = bIsdeleted;
    data['_statusid'] = iStatusid;
    data['name'] = name;
    data['lastname'] = lastname;
    data['password'] = password;
    data['email'] = email;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['_id'] = sId;
    data['_createdate'] = sCreatedate;
    data['_updatedate'] = sUpdatedate;
    data['__v'] = iV;
    data['zodiacSign'] = zodiac;
    return data;
  }
}
