import 'dart:io';

import 'package:bito/src/component.dart';
import 'package:bito/src/context.dart';
import 'package:bito/src/context-helper/response-helper.dart';

const DEFAULT_PORT = 3000;

class Bito {

  int port;

  InternetAddress host;

  BitoComponent first;
  BitoComponent last;

  ///
  ///
  setup([int port = DEFAULT_PORT, InternetAddress host = null]) {
    this.port = port;
    this.host = host;
  }

  use(BitoComponent component) {
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
                BitoContext context = new BitoContext(
                    request, request.response, {}, {}, {});

                if (first != null) {
                  first.invoke(context);
                }

                HttpResponse response = context.response;

                if (!ContextResponseHelper.isDoNotclose(context)) {
                  response.close();
                }
              });
            });

  }

}