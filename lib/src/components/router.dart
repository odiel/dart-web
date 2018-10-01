import 'dart:io';

import 'package:bito/framework.dart';
import 'package:bito/src/components/router/route.dart';
import 'package:bito/src/context-helper/router-helper.dart';

class Router extends BitoComponent {

  static const METHODS_ANY = "*";
  static const METHODS_GET = "GET";
  static const METHODS_POSST = "POST";
  static const METHODS_PUT = "PUT";
  static const METHODS_DELETE = "DELETE";

  List<Route> routes = [];

  BitoContext context;

  @override
  invoke(BitoContext context) {
    _handle(context);

    next(context);
  }

  match(String uri, Function(BitoContext context) handler) {
    addRoute(new Route([METHODS_ANY], uri, handler));
  }

  matchMethods(String uri, List<String> methods, RouteHandler handler) {
    addRoute(new Route(methods, uri, handler));
  }

  get(String uri, RouteHandler handler) {
    addRoute(new Route(["GET"], uri, handler));
  }

  post(String uri, RouteHandler handler) {
    addRoute(new Route(["POST"], uri, handler));
  }

  put(String uri, RouteHandler handler) {
    addRoute(new Route(["PUT"], uri, handler));
  }

  delete(String uri, RouteHandler handler) {
    addRoute(new Route(["DELETE"], uri, handler));
  }

  head(String uri, RouteHandler handler) {
    addRoute(new Route(["HEAD"], uri, handler));
  }

  void addRoute(Route route) {
    routes.add(route);
  }

  void _handle(BitoContext context) {
    HttpRequest request = context.request;

    for (Route route in routes) {
      if (
        (
          route.methods.contains(request.method) ||
          route.methods.contains(METHODS_ANY)
        ) &&
        route.matches(request.uri.toString()))
      {
          ContextRouterHelper.setRouteParams(context, route.routeParameters);

          route.handle(context);

          break;
      }
    }
  }

}

