
import 'dart:io';

import 'package:bito/service.dart';

class BitoContext {

  HttpRequest request;

  HttpResponse response;

  Map<String, Object> shareds;

  Map<String, BitoService> services;

  Map<String, Object> configurations;

  BitoContext(this.request, this.response, this.shareds, this.services, this.configurations);

}