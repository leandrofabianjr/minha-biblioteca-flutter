import 'package:graphql_flutter/graphql_flutter.dart';

class GqlItems {
  static get query => gql(r'''
    query {
      items {
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
}
