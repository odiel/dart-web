import 'package:bito/context.dart';

class ContextRouterHelper {

  static setRouteParams(BitoContext context, Map routeParameters) {
    context.shareds['bito_router_response_params'] = routeParameters;
  }

  static Map<String, String> getRouteParams(BitoContext context) {
    return context.shareds['bito_router_response_params'];
  }

}