import 'package:graphql_flutter/graphql_flutter.dart';

class GqlItems {
  static get subscription => gql(r'''
    subscription {
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
