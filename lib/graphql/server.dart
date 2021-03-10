import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Server {
  static const _END_POINT = 'minha-biblioteca-hasura.herokuapp.com/v1/graphql';

  static String? _token;

  static final HttpLink httpLink = HttpLink('https://$_END_POINT');

  static final AuthLink authLink =
      AuthLink(getToken: () => _token!, headerKey: 'x-hasura-admin-secret');

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

  static Future init(String token) async {
    _token = token;
    // await initHiveForFlutter();
  }

  static ValueNotifier<GraphQLClient> get client {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(
            // store: HiveStore(),
            ),
        link: link,
      ),
    );

    return client;
  }
}
