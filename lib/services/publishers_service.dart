import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_publishers.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/services/auth.dart';

class PublishersService {
  final _client = Server.client;

  Future<List<Publisher>> search({
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
      document: GqlPublishers.querySearch,
      variables: variables,
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    return (result.data!['publishers'] as List)
        .map((json) => Publisher.fromJson(json))
        .toList();
  }
}
