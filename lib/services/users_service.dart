import 'package:minha_biblioteca/models/user.dart';
import 'package:uuid/uuid.dart';

class UsersService {
  Future<User> create() async {
    return new User(email: '', name: '', uuid: Uuid().v4());
  }
}
