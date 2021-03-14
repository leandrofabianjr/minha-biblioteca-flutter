import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_authors.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/author.dart';
import 'package:minha_biblioteca/models/exceptions.dart';

class AuthorsService {
  final _client = Server.client;

  Future<List<Author>> search({
    required String userId,
    int? limit,
    String? searchByName,
  }) async {
    var variables = <String, dynamic>{
      'userId': userId,
    };

    if (limit != null) variables['limit'] = limit;
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
