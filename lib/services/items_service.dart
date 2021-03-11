import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/graphql/gql_items.dart';
import 'package:minha_biblioteca/graphql/server.dart';
import 'package:minha_biblioteca/models/exceptions.dart';
import 'package:minha_biblioteca/models/item.dart';

class ItemsService {
  final _client = Server.client;

  Future<List<Item>> fetch() async {
    final result = await _client.query(QueryOptions(document: GqlItems.query));

    if (result.hasException) {
      throw FetchFailure(result.exception);
    }

    return result.data!['items'].map((json) => Item.fromJson(json)).toList();
  }
}
