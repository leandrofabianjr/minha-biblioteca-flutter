import 'package:graphql_flutter/graphql_flutter.dart';

class GqlItems {
  static get queryList => gql(r'''
query (
  $userId: String!,
  $offset: Int = 0,
  $limit: Int = 1,
  $order_by: [items_order_by!] = {description: asc},
  $searchDescription: String = "%%",
  $searchAuthor: String = "%%",
  $searchGenre: String = "%%",
  $searchPublisher: String = "%%",
  $searchLocation: String = "%%"
) {
  items_aggregate {
    aggregate {
      totalCount: count
    }
  }
  items(
    offset: $offset,
    limit: $limit,
    order_by: $order_by,
    where: {
      user_id: {_eq: $userId},
      description: {_ilike: $searchDescription},
      location: {description: {_ilike: $searchLocation}},
      authors: {author: {name: {_ilike: $searchAuthor}}},
      genres: {genre: {description: {_ilike: $searchGenre}}},
      publishers: {publisher: {name: {_ilike: $searchPublisher}}}
    }
  ) {
    description
    authors {
      author {
        name
      }
    }
    genres {
      genre {
        description
      }
    }
    year
    publishers {
      publisher {
        name
      }
    }
    location {
      description
    }
  }
}
''');

  static get insert => gql(r'''
mutation ($items: [items_insert_input!]! = {}) {
    insert_items(objects: $items) {
        returning {
            uuid
        }
    }
}
''');
}
