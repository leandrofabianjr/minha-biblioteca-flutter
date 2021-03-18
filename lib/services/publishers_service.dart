import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_publishers.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/publisher.dart';
import 'package:minha_biblioteca/models/exceptions.dart';

class PublishersService {
  final _client = Server.client;

  Future<List<Publisher>> search({
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
