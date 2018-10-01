import 'package:bito/framework.dart';

class MyComponent extends BitoComponent {

  @override
  invoke(BitoContext context) {
    var response = context.response;

    next(context);

    response.write("Hello World!");
    response.close();
  }

}

main(List<String> args) async {

  Bito server = Bito()
    ..setup(3000)
    ..use(MyComponent())
    ..listen()
  ;
}
