
import 'dart:io';

import 'service.dart';

class Context {

  HttpRequest request;

  HttpResponse response;

  Map<String, Object> shareds;

  Map<String, Service> services;

  Map<String, Object> configurations;

  Context(this.request, this.response, this.shareds, this.services, this.configurations);

}