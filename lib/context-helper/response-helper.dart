import 'package:bito/context.dart';

class ContextResponseHelper {

  static void doNotClose(BitoContext context) {
    context.shareds['bito_response_do_not_close'] = true;
  }

  static void responseHandled(BitoContext context) {
    context.shareds['bito_response_handled'] = true;
  }

  static bool isDoNotclose(BitoContext context) {
    return context.shareds.containsKey('bito_response_do_not_close');
  }

  static bool isResponseHandled(BitoContext context) {
    return context.shareds.containsKey('bito_response_handled');
  }

}