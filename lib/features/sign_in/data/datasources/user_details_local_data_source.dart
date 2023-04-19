import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/const/shared_preferences_keys.dart';
import '../../../sign_up/data/models/registered_user_model.dart';
import '../../domain/entities/user_details_entity.dart';
import '../../domain/usecases/login_user.dart';

abstract class UserDetailsLocalDataSource {
  Future<UserDetails> getUserDetails(LoginDetails loginDetails);
}

class UserDetailLocalDataSourceImpl implements UserDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;

  const UserDetailLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserDetails> getUserDetails(LoginDetails loginDetails) async {
    try {
      List<RegisteredUserModel> userList = [];
      final jsonString = sharedPreferences.getString(CachedModelKeys.registeredUserModel);
      if(jsonString != null) {
        userList = registeredUserModelFromJson(jsonString);
        if(userList.any((e) => e.email == loginDetails.email && e.password == loginDetails.password )) {
          RegisteredUserModel user = userList.firstWhere((e) => e.email == loginDetails.email && e.password == loginDetails.password);
          return UserDetails(name: user.name, email: user.email, phoneNumber: user.phoneNumber);
        }
        if(userList.any((e) => e.email == loginDetails.email)) {
          throw 'Password not correct. Please try again';
        }
      }
      throw 'User not found. Please check the email';

    } catch (e) {
      throw ServerException(errorMessage: '$e', unexpectedError: true);
    }
  }
}
