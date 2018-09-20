import 'dart:io';
import 'component.dart';

import 'context.dart';

const DEFAULT_PORT = 3000;

class App {

  int port;

  InternetAddress host;

  Component first;
  Component last;

  ///
  ///
  setup([int port = DEFAULT_PORT, InternetAddress host = null]) {
    this.port = port;
    this.host = host;
  }

  use(Component component) {
    if (first == null) first = component;
    if (last == null) last = component;

    if (last != component) {
      last.setNext(component);
      last = component;
    }
  }

  listen() {
    if (host == null) {
      host = InternetAddress.anyIPv6;
    }

    HttpServer
        .bind(host, port)
        .then(
            (server) {
              print('Server started at http://${server.address.host}:${server.port}');

              server.listen((HttpRequest request) {
                Context context = new Context(request, request.response, null, null, null);

                first.invoke(context);
              });
            });

  }

}