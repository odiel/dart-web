
import 'package:bito/context.dart';

import 'package:bito/context-helper/response-helper.dart';

typedef RouteHandler = Function(BitoContext context);

class Route {

  List<String> _methods;

  List<String> get methods => _methods;

  String _uri;

  RouteHandler _handler;

  RegExp _uriPattern;

  List<Map> _patternParts = [];
  List<String> _namedParameters = [];

  Map<String, String> routeParameters = {};

  Route(List<String> methods, String uri, RouteHandler handler) {
    this._methods = methods;
    this._uri = uri;
    this._handler = handler;

    _buildPattern();
  }

  bool matches(String requestUri) {
    Iterable<Match> matches = _uriPattern.allMatches(requestUri);

    if (matches.length > 0) {
      Match match = matches.elementAt(0);

      for (int i = 0; i < _namedParameters.length; i++) {
        String value = match.group(i+1);

        routeParameters[_namedParameters[i]] = value;
      }

      return true;
    }

    return false;
  }

  void handle(BitoContext context) {
    ContextResponseHelper.responseHandled(context);

    _handler(context);
  }

  void _buildPattern() {
    List<String> parts = _uri.split('/');
    parts.remove(parts[0]);
    String pattern = '^';

    String parameterNamePrefix = '_param';
    int parameterNameIndex = 0;

    for (String part in parts) {
      List<String> segments = part.split(':');

      String parameterName = parameterNamePrefix + parameterNameIndex.toString();
      String expression = segments[0];

      if (segments.length == 1) {
        if (part.startsWith(':')) {
          parameterName = segments[0];
          expression = '.*';
        }
      } else {
        parameterName = segments[1];
        expression = segments[0];

        if (expression.length == 0) expression = '.*';
      }

      if (expression.startsWith('(') && expression.endsWith(')')) {
        expression = expression.substring(1, expression.length - 1);
      }

      _patternParts.add({"name": parameterName, "expression": '(' + expression + ')'});

      _namedParameters.add(parameterName);

      parameterNameIndex++;
    }

    for (Map patternPart in _patternParts) {
      pattern +=  '\/' + patternPart['expression'];
    }

    pattern += '\$';

    _uriPattern = RegExp(pattern);
  }

}