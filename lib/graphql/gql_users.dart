import 'package:graphql_flutter/graphql_flutter.dart';

class GqlUsers {
  static get querySearch => gql(r'''
    query ($google_uid: String = "") {
      users(where: {google_uid: {_eq: $google_uid}}) {
        google_uid
        created_at
        email
        name
        profile_picture_url
        updated_at
        uuid
      }
    }
  ''');

  static get insertOne => gql(r'''
    mutation ($user: users_insert_input!) {
      insert_users_one(object: $user) {
        created_at
        email
        google_uid
        name
        profile_picture_url
        updated_at
        uuid
      }
    }
  ''');
}
