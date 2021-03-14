import 'package:graphql_flutter/graphql_flutter.dart';

class GqlAuthors {
  static get querySearch => gql(r'''
query (
  $userId: String!,
  $searchByName: String! = "%%",
  $limit: Int! = 10
) {
  authors(
    limit: $limit,
    order_by: { name: asc },
    where: {
      user_id: {_eq: $userId},
      name: {_ilike: $searchByName}
    },
  ) {
    name
    uuid
  }
}
''');
}
