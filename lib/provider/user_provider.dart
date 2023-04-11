import 'package:flutter/widgets.dart';
import 'package:umujyanama/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      fullName: '',
      email: '',
      phoneNumber: '',
      idNumber: '',
      type: '',
      village: '',
 

      );
  User get user => _user;
  void setUser(dynamic user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
