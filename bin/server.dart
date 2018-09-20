import '../framework/app.dart';
import '../framework/components/requestLogger.dart';
import '../framework/components/router.dart';
import '../framework/context.dart';

main(List<String> args) async {
  App app = App();
  app.setup(3000);

  app.use(RequestLogger());

  Router router = Router();
  router
      ..match("/", (Context context) {
        print("home");
      })
      ..matchGET("/", (Context context) {
        print("more home");
      })
  ;
  app.use(router);

  app.listen();
}


