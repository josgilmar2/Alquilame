import 'package:alquilame/config/locator.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/repositories/repositories.dart';
import 'package:alquilame/services/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@Order(2)
@singleton
class UserService {
  late LocalStorageService _localStorageService;
  late UserRepository _userRepository;

  UserService() {
    _userRepository = getIt<UserRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  Future<AllDwellingsResponse> getUserFavouriteDwellings(int page) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      AllDwellingsResponse response =
          await _userRepository.getUserFavouritesDwellings(page);
      return response;
    }
    throw Exception("Failed to load user favourite dwellings");
  }

  Future<AllUserResponse> getAllUsers(int page) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      AllUserResponse response = await _userRepository.getAllUsers(page);
      return response;
    }
    throw Exception("Failed to get all users");
  }

  Future<UserResponse> editPassword(
      String oldPassword, String newPassword, String verifyNewPassword) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      UserResponse response = await _userRepository.editPassword(
          oldPassword, newPassword, verifyNewPassword);
      return response;
    }
    throw Exception("Failed to edit password");
  }

  Future<UserResponse> editProfile(
      String address, String phoneNumber, String fullName) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      UserResponse response =
          await _userRepository.editProfile(address, phoneNumber, fullName);
      return response;
    }
    throw Exception("Failed to edit profile");
  }

  /*Future<UserResponse> editProfile(
      EditProfileRequest request, PlatformFile file) {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      return _userRepository.editProfile(request, file, token);
    }
    throw Exception("Failed to edit profile");
  }*/

  Future<void> deleteProfile() async {
    await _userRepository.deleteProfile();
  }

  Future<UserResponse> editAvatar(PlatformFile file) async {
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      UserResponse response = await _userRepository.editAvatar(file, token);
      return response;
    }
    throw Exception("Failed to edit avatars");
  }
}
