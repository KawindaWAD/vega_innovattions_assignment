import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/strings/shared_preferences_keys.dart';
import '../../domain/usecases/register_user.dart';
import '../models/registered_user_model.dart';

abstract class RegisterUserLocalDataSource {
  Future<bool> registerUser(UserRegistrationInfo info);
}

class RegisterUserLocalDataSourceImpl implements RegisterUserLocalDataSource {
  final SharedPreferences sharedPreferences;

  const RegisterUserLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool> registerUser(UserRegistrationInfo info) async {
    try {
      RegisteredUserModel newUser = RegisteredUserModel(
        name: info.name,
        email: info.email,
        phoneNumber: info.phoneNumber,
        password: info.password,
      );

      List<RegisteredUserModel> userList = [];
      final jsonString = sharedPreferences.getString(CachedModelKeys.registeredUserModel);
      if(jsonString != null) {
        userList = registeredUserModelFromJson(jsonString);
        if(userList.any((e) => e.email == newUser.email)) {
          throw 'Email already taken. Please try another email';
        }
        if(userList.any((e) => e.phoneNumber == newUser.phoneNumber)) {
          throw 'Phone number already taken. Please try another number';
        }
      }

      userList.add(newUser);

      sharedPreferences.setString(CachedModelKeys.registeredUserModel, registeredUserModelToJson(userList));
      return true;

    } catch (e) {
      throw ServerException(errorMessage: '$e', unexpectedError: true);
    }
  }
}