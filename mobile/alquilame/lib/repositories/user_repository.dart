import 'dart:convert';

import 'package:alquilame/models/models.dart';
import 'package:alquilame/rest/rest.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:alquilame/config/locator.dart';

@Order(-1)
@singleton
class UserRepository {
  late RestAuthenticatedClient _client;

  UserRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> profile() async {
    String url = "/user/profile";

    var jsonResponse = await _client.get(url);
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<AllDwellingsResponse> getUserFavouritesDwellings(int page) async {
    String url = "/user/favourites";

    var jsonResponse = await _client.get(url);
    return AllDwellingsResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<AllUserResponse> getAllUsers(int page) async {
    String url = "/user/?page=$page";

    var jsonResponse = await _client.get(url);
    return AllUserResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<UserResponse> editPassword(
      String oldPassword, String newPassword, String verifyNewPassword) async {
    String url = "/user/changePassword";

    var jsonResponse = await _client.put(
        url,
        EditPasswordRequest(
            oldPassword: oldPassword,
            newPassword: newPassword,
            verifyNewPassword: verifyNewPassword));
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }

  Future<UserResponse> editProfile(
      String address, String phoneNumber, String fullName) async {
    String url = "/user/";

    var jsonResponse = await _client.put(
        url,
        EditProfileRequest(
            address: address, phoneNumber: phoneNumber, fullName: fullName));
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }

  /*Future<UserResponse> editProfile(
      EditProfileRequest request, PlatformFile file, String token) async {
    String url = "/user/";

    var jsonResponse = await _client.putMultiPart(url, request, file, token);
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }*/

  Future<void> deleteProfile() async {
    String url = "/user/delete";

    await _client.delete(url);
  }

  Future<UserResponse> editAvatar(PlatformFile file, String token) async {
    String url = "/user/changeAvatar";
    var jsonResponse = await _client.putMultiPart(url, null, file, token);
    return UserResponse.fromJson(jsonDecode(jsonResponse));
  }
}
