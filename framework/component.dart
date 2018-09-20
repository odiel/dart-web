
import 'context.dart';

abstract class Component {

  Component _next;

  setNext(Component next){
    _next = next;
  }

  getNext() {
    return _next;
  }

  next(Context context) {
    if (_next is Component) {
      _next.invoke(context);
    }
  }

  invoke(Context context);

}