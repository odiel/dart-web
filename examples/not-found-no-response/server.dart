import 'package:bito/framework.dart';
import 'package:bito/components/simple_request_logger.dart';
import 'package:bito/components/no_response.dart';
import 'package:bito/context-helper/response-helper.dart';

class MyComponent extends BitoComponent {

  @override
  invoke(BitoContext context) {
    var request = context.request;
    var response = context.response;

    if (request.uri.toString() == '/') {
      response.writeln('Hello World');
      response.close();
    }

    ContextResponseHelper.responseHandled(context);

    next(context);
  }

}

main(List<String> args) async {

  Bito server = Bito()
    ..setup(3000)
    ..use(SimpleRequestLogger())
    ..use(MyComponent())
    ..use(NoResponse())
    ..listen()
  ;
}
