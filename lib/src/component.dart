
import './context.dart';

abstract class BitoComponent {

  BitoComponent _next;

  setNext(BitoComponent next){
    _next = next;
  }

  getNext() {
    return _next;
  }

  next(BitoContext context) {
    if (_next is BitoComponent) {
      _next.invoke(context);
    }
  }

  invoke(BitoContext context);

}