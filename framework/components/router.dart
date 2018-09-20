import 'dart:io';

import '../component.dart';
import '../context.dart';
import 'router/route.dart';

class Router extends Component {

  static const METHODS_ANY = "*";
  static const METHODS_GET = "GET";
  static const METHODS_POSST = "POST";
  static const METHODS_PUT = "PUT";
  static const METHODS_DELETE = "DELETE";

  List<Route> routes = [];

  Context context;

  @override
  invoke(Context context) {
    _handle(context);

    context.request.response.write('Hello, world!');
    context.request.response.close();

    next(context);
  }

  match(String uri, Function(Context context) handler) {
    addRoute(new Route([METHODS_ANY], uri, handler));
  }

  matchMethods(String uri, List<String> methods, Function(Context context) handler) {
    addRoute(new Route(methods, uri, handler));
  }

  matchGET(String uri, Function(Context context) handler) {
    addRoute(new Route(["GET"], uri, handler));
  }

  matchPOST(String uri, Function(Context context) handler) {
    addRoute(new Route(["POST"], uri, handler));
  }

  matchPUT(String uri, Function(Context context) handler) {
    addRoute(new Route(["PUT"], uri, handler));
  }

  matchDELETE(String uri, Function(Context context) handler) {
    addRoute(new Route(["DELETE"], uri, handler));
  }

  matchHEAD(String uri, Function(Context context) handler) {
    addRoute(new Route(["HEAD"], uri, handler));
  }

  void addRoute(Route route) {
    routes.add(route);
  }

  void _handle(Context context) {
    HttpRequest request = context.request;

    bool routeHandled = false;

    for (Route route in routes) {
      if (
        (
          route.methods.indexOf(request.method) > -1 ||
          route.methods.indexOf(METHODS_ANY) > -1
        ) &&
        route.matches(request.uri.toString()))
      {
          routeHandled = route.handle(context);
      }

      if (routeHandled) {
        break;
      }
    }
  }

}

