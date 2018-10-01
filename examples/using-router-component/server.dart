import 'package:bito/framework.dart';
import 'package:bito/src/components/router.dart';
import 'package:bito/src/context-helper/router-helper.dart';

main(List<String> args) async {

  Router router = Router();
  router
    ..match("/", (BitoContext context) {
      context.response.write("home");
    })
    ..match("/author/[a-z0-9]*", (BitoContext context) {
      Map<String, String> responseParameters = ContextRouterHelper.getRouteParams(context);

      context.response.write("Author ${responseParameters["_param1"]} page");
    })
    ..get("/author/([a-z0-9]*):author/book/([a-z0-9-_]*):book", (BitoContext context) {
      Map<String, String> responseParameters = ContextRouterHelper.getRouteParams(context);

      context.response.write("Book ${responseParameters["book"]} from Author ${responseParameters["author"]}");
    });

  Bito server = Bito()
    ..setup(3000)
    ..use(router)
    ..listen()
  ;
}

