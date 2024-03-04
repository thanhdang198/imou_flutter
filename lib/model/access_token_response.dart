class AccessTokenResponse {
  Result? result;
  String? id;

  AccessTokenResponse({this.result, this.id});

  AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Result {
  String? msg;
  String? code;
  Data? data;

  Result({this.msg, this.code, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? expireTime;
  String? currentDomain;
  String? accessToken;

  Data({this.expireTime, this.currentDomain, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    expireTime = json['expireTime'];
    currentDomain = json['currentDomain'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expireTime'] = expireTime;
    data['currentDomain'] = currentDomain;
    data['accessToken'] = accessToken;
    return data;
  }
}
