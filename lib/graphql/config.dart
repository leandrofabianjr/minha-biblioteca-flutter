import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static const _END_POINT = 'minha-biblioteca-hasura.herokuapp.com/v1/graphql';

  static String? _token;

  static final HttpLink httpLink = HttpLink('https://$_END_POINT');

  static final AuthLink authLink = AuthLink(getToken: () => _token);

  static final websocketLink = WebSocketLink(
    'wss://$_END_POINT',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: () async {
        return {
          'headers': {'Authorization': _token},
        };
      },
    ),
  );

  static final Link link = authLink.concat(httpLink).concat(websocketLink);

  static Future<ValueNotifier<GraphQLClient>> initailizeClient(
    String token,
  ) async {
    _token = token;

    await initHiveForFlutter();

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: link,
      ),
    );

    return client;
  }
}
