import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_users.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/models/user.dart';
import 'package:uuid/uuid.dart';

class UsersService {
  final _client = Server.client;

  Future<User?> create({
    required String googleUid,
    required String email,
    required String name,
    String? profilePictureUrl,
  }) async {
    final user = new User(
      uuid: Uuid().v4(),
      email: email,
      name: name,
      profilePictureUrl: profilePictureUrl,
      googleUid: googleUid,
    );

    final result = await _client.query(QueryOptions(
      document: GqlUsers.querySearch,
      variables: {'user': user},
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    final json = (result.data?['users'] as List?)?.first;
    print(json);
    return User.fromJson(json);
  }

  Future<User?> getByGoogleUid({required String googleUid}) async {
    final result = await _client.query(QueryOptions(
      document: GqlUsers.querySearch,
      variables: {'google_uid': googleUid},
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    final json = (result.data?['users'] as List?)?.first;
    if (json == null) {
      return null;
    }

    return User.fromJson(json);
  }
}
