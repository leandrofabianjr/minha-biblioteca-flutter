import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_items.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/models/item.dart';
import 'package:minha_biblioteca/models/paginated_response.dart';

class ItemsService {
  final _client = Server.client;

  Future<PaginatedResponse<Item>> fetch({
    required String userId,
    int? offset,
    int? limit,
    Map<dynamic, dynamic>? orderBy,
    String? searchAuthor,
    String? searchDescription,
    String? searchGenre,
    String? searchPublisher,
    String? searchLocation,
  }) async {
    var variables = <String, dynamic>{
      'userId': userId,
    };

    if (offset != null) variables['limit'] = offset;
    if (limit != null) variables['limit'] = limit;
    if (orderBy != null) variables['limit'] = orderBy;
    if (searchAuthor != null) variables['limit'] = searchAuthor;
    if (searchDescription != null) variables['limit'] = searchDescription;
    if (searchGenre != null) variables['limit'] = searchGenre;
    if (searchPublisher != null) variables['limit'] = searchPublisher;
    if (searchLocation != null) variables['limit'] = searchLocation;

    final result = await _client.query(QueryOptions(
      document: GqlItems.queryList,
      variables: variables,
    ));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    final totalCount =
        result.data!['items_aggregate']['aggregate']['totalCount'];

    final data = (result.data!['items'] as List)
        .map((json) => Item.fromJson(json))
        .toList();

    return PaginatedResponse(totalCount, data);
  }
}
