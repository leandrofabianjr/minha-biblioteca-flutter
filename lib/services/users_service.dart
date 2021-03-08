import 'package:minha_biblioteca/models/user.dart';

class UsersService {
  Future<User> create() async {
    return new User(email: '', name: '');
  }
}
