import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  aa() async {
    await initHiveForFlutter();
  }

  static final HttpLink httpLink =
      HttpLink('https://minha-biblioteca-hasura.herokuapp.com/v1/graphql');

  static String _token;

  static final AuthLink authLink = AuthLink(getToken: () => _token);

  final websocketLink = WebSocketLink(
    url: 'wss://minha-biblioteca-hasura.herokuapp.com/v1/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initPayload: () async {
        return {
          'headers': {'Authorization': _token},
        };
      },
    ),
  );

  static final Link link = authLink.concat(httpLink).concat(websocketLink);

  static ValueNotifier<GraphQLClient> initailizeClient(String token) {
    _token = token;

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: link,
      ),
    );

    return client;
  }
}
