import 'package:bito/framework.dart';

class SimpleRequestLogger extends BitoComponent {

  @override
  invoke(BitoContext context) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;

    next(context);

    int msRunning = DateTime.now().millisecondsSinceEpoch - timestamp;

    print(
        '<- ' + context.response.statusCode.toString() +
        ' in ' + msRunning.toString() + 'ms' +
        ' | -> ' + context.request.method + " " + context.request.uri.toString()
    );
  }

}