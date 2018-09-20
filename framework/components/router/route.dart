import 'dart:io';
import '../../context.dart';

class Route {

  List<String> methods;

  String uri;

  Function(Context context) handler;

  Route(this.methods, this.uri, this.handler);

  bool matches(String requestUri) {
    return true;
  }

  bool handle(Context context) {
    String uri = context.request.uri.toString();

    this.handler(context);

    return true;
  }

}