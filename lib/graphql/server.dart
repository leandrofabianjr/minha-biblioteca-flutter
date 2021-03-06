import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:minha_biblioteca/env.dart';

class Server {
  static const _END_POINT = 'minha-biblioteca-hasura.herokuapp.com/v1/graphql';

  static String _token = ENV['ADMIN_PASS']!;

  static final HttpLink httpLink = HttpLink('https://$_END_POINT');

  static final AuthLink authLink =
      AuthLink(getToken: () => _token, headerKey: 'x-hasura-admin-secret');

  static final websocketLink = WebSocketLink(
    'wss://$_END_POINT',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: () async {
        return {
          'headers': {'x-hasura-admin-secret': _token},
        };
      },
    ),
  );

  // static final Link link = authLink.concat(httpLink).concat(websocketLink);
  static final Link link = Link.split((request) => request.isSubscription,
      websocketLink, authLink.concat(httpLink));

  static GraphQLClient get client {
    return GraphQLClient(
      cache: GraphQLCache(
          // store: HiveStore(),
          ),
      link: link,
    );
  }
}
