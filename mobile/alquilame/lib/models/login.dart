import 'package:alquilame/home/home.dart';

class LoginResponse {
  String? id;
  String? username;
  String? avatar;
  String? fullName;
  String? address;
  String? email;
  String? phoneNumber;
  int? numPublications;
  bool? enabled;
  String? createdAt;
  String? role;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.avatar,
      this.fullName,
      this.address,
      this.email,
      this.phoneNumber,
      this.numPublications,
      this.enabled,
      this.createdAt,
      this.role,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    address = json['address'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    numPublications = json['numPublications'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    role = json['role'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['numPublications'] = this.numPublications;
    data['enabled'] = this.enabled;
    data['createdAt'] = this.createdAt;
    data['role'] = this.role;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }

  LoginResponse.fromUserReResponse(UserResponse response) {
    this.id = response.id;
    this.username = response.username;
    this.avatar = response.avatar;
    this.fullName = response.fullName;
    this.address = response.address;
    this.email = response.email;
    this.phoneNumber = response.phoneNumber;
    this.numPublications = response.numPublications;
    this.enabled = response.enabled;
    this.role = response.role;
  }
}

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

class RefreshTokenResponse {
  int? numPublications;
  String? token;
  String? refreshToken;

  RefreshTokenResponse({this.numPublications, this.token, this.refreshToken});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    numPublications = json['numPublications'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numPublications'] = this.numPublications;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
