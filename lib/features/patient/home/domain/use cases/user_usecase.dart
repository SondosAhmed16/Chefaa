import 'package:chefaa/core/services/share_services.dart';
import 'package:chefaa/core/shared%20classes/user_entity.dart';
import 'package:chefaa/features/auth/data/model/login_response_model.dart';

class UserUseCase {
  UserEntity fromAuthResponse(LoginResponseModel loginResponse) {
    return UserEntity.fromLoginResponseModel(loginResponse);
  }

  Future<void> saveUserToPrefs(UserEntity user) async {
    await ShareServices.saveString('userId', user.id.trim());
    await ShareServices.saveString('userName', user.name.trim());
  }

  Future<UserEntity?> loadUserFromPrefs() async {
    final id = await ShareServices.getString('userId');
    final name = await ShareServices.getString('userName');

    if (id == null || id.isEmpty) {
      return null;
    }

    return UserEntity(id: id.trim(), name: name?.trim() ?? '', role: '');
  }

  Future<void> clearUserFromPrefs() async {
    await ShareServices.saveString('userId', '');
    await ShareServices.saveString('userName', '');
  }
}
