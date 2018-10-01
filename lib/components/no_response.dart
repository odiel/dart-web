import 'dart:io';

import 'package:bito/framework.dart';
import 'package:bito/context-helper/response-helper.dart';

class NoResponse extends BitoComponent {

  @override
  invoke(BitoContext context) {
    if (ContextResponseHelper.isResponseHandled(context) == false) {
      HttpResponse response = context.response;

      response.statusCode = 404;
      response.writeln('Not found');
    }

    next(context);
  }

}