import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_locations.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/location.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/services/auth.dart';

class LocationsService {
  final _client = Server.client;

  Future<List<Location>> search({
    int limit = 10,
    String? searchByDescription,
  }) async {
    final user = await Auth().currentUser;
    var variables = <String, dynamic>{
      'userId': user!.uuid,
      'limit': limit,
    };

    if (searchByDescription != null)
      variables['searchByDescription'] = '%$searchByDescription%';

    final result = await _client.query(QueryOptions(
      document: GqlLocations.querySearch,
      variables: variables,
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    return (result.data!['locations'] as List)
        .map((json) => Location.fromJson(json))
        .toList();
  }
}
