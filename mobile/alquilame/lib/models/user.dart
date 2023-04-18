import 'package:alquilame/models/login.dart';

class AllUserResponse {
  List<UserResponse>? content;
  int? totalElements;
  int? totalPages;
  int? number;
  int? size;

  AllUserResponse(
      {this.content,
      this.totalElements,
      this.totalPages,
      this.number,
      this.size});

  AllUserResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <UserResponse>[];
      json['content'].forEach((v) {
        content!.add(new UserResponse.fromJson(v));
      });
    }
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    number = json['number'];
    size = json['size'];
  }
}

class UserResponse {
  String? id;
  String? username;
  String? avatar;
  String? fullName;
  String? address;
  String? email;
  String? phoneNumber;
  String? role;
  int? numPublications;
  String? createdAt;

  UserResponse(
      {this.id,
      this.username,
      this.avatar,
      this.fullName,
      this.address,
      this.email,
      this.phoneNumber,
      this.role,
      this.numPublications,
      this.createdAt});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    address = json['address'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    numPublications = json['numPublications'];
    createdAt = json['createdAt'];
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
    data['role'] = this.role;
    data['numPublications'] = this.numPublications;
    data['createdAt'] = this.createdAt;
    return data;
  }

  UserResponse.fromLoginResponse(LoginResponse response) {
    this.id = response.id;
    this.username = response.username;
    this.avatar = response.avatar;
    this.fullName = response.fullName;
    this.address = response.address;
    this.email = response.email;
    this.phoneNumber = response.phoneNumber;
    this.numPublications = response.numPublications;
    this.role = response.role;
  }
}

class UserRequest {
  String? username;
  String? email;
  String? address;
  String? phoneNumber;
  String? fullName;
  String? password;
  String? verifyPassword;

  UserRequest(
      {this.username,
      this.email,
      this.address,
      this.phoneNumber,
      this.fullName,
      this.password,
      this.verifyPassword});

  UserRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['verifyPassword'] = this.verifyPassword;
    return data;
  }
}

class EditPasswordRequest {
  String? oldPassword;
  String? newPassword;
  String? verifyNewPassword;

  EditPasswordRequest(
      {this.oldPassword, this.newPassword, this.verifyNewPassword});

  EditPasswordRequest.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    verifyNewPassword = json['verifyNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['verifyNewPassword'] = this.verifyNewPassword;
    return data;
  }
}

class EditProfileRequest {
  String? fullName;
  String? address;
  String? phoneNumber;

  EditProfileRequest({this.fullName, this.address, this.phoneNumber});

  EditProfileRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
