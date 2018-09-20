
import '../component.dart';
import '../context.dart';

class RequestLogger extends Component {

  @override
  invoke(Context context) {
    next(context);

    print("<- " + context.response.statusCode.toString() +  " | -> " + context.request.method + " " + context.request.uri.toString());
  }

}