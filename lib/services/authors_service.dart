import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_authors.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/services/auth.dart';

class AuthorsService {
  final _client = Server.client;

  Future<List<Author>> search({
    int limit = 10,
    String? searchByName,
  }) async {
    final user = await Auth().currentUser;
    var variables = <String, dynamic>{
      'userId': user!.uuid,
      'limit': limit,
    };

    if (searchByName != null) variables['searchByName'] = '%$searchByName%';

    final result = await _client.query(QueryOptions(
      document: GqlAuthors.querySearch,
      variables: variables,
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    return (result.data!['authors'] as List)
        .map((json) => Author.fromJson(json))
        .toList();
  }
}
