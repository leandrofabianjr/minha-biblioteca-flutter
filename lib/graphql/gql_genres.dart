import 'package:graphql_flutter/graphql_flutter.dart';

class GqlGenres {
  static get querySearch => gql(r'''
query (
  $userId: String!,
  $searchByDescription: String! = "%%",
  $limit: Int! = 10
) {
  genres(
    limit: $limit,
    order_by: { description: asc },
    where: {
      user_id: {_eq: $userId},
      description: {_ilike: $searchByDescription}
    },
  ) {
    description
    uuid
  }
}
''');
}
