import 'dart:async' show Future;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'database.dart';

class Service {
  // The [Router] can be used to create a handler, which can be used with [shelf_io.serve].
  Handler get handler {
    final router = Router();

    router.mount('/menu/', Api().router);

    // Catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Endpoint not found');
    });

    return router;
  }
}

class Api {
  Future<Response> _messages(Request request) async {
    return Response.ok('{"lUca": "Prova"}');
  }

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    // A handler can have more that one route.
    router.get('/messages', _messages);
    router.get('/messages/', _messages);

    // This nested catch-all, will only catch /api/.* when mounted above.
    // Notice that ordering if annotated handlers and mounts is significant.
    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}

void main() async {
  // Connect to all DBs
  final db_menu = Database('menu').getDB;
  final db_classifica = Database('classifica').getDB;

  await db_menu.open();
  // await db_classifica.open();

  var pranzo = db_menu.collection('pranzo');

  var pasti = await pranzo.find().toList();
  print(pasti);

  await db_menu.close();

  // Start the API server
  // final service = Service();
  // // Run shelf server and host a [Service] instance on port 80.
  // final server = await io.serve(service.handler, '0.0.0.0', 80);
  // print('Server running on localhost:${server.port}');
}
