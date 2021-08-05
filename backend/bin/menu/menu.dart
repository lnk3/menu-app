import 'dart:io' show Platform;
import 'dart:convert';
import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';
import '../environment.dart';

Future<String> get_pranzo() async {
  var db_endpoint = 'menu';

  Completer c = new Completer();

  var db = Db('mongodb://$host:$port/$db_endpoint');
  await db.open();
  await db.authenticate('root', 'password');

  DbCollection pranzo = db.collection('pranzo');
  await pranzo.legacyFind().forEach((element) {
    print(element);
  });

  await db.close();
  // await db.open().then((o) {
  //   String data = '[';

  //   DbCollection collections = db.collection('menu');
  //   collections.find().forEach((element) {
  //     data += json.encode(element) + ',';
  //   }).then((value) {
  //     data = data.substring(0, data.length - 1);
  //     data += ']';
  //     c.complete(data);
  //   });
  // });
  // return c.future;
}

// addMeals(List<Food> f, Database d) async {}

// deleteAllMeals(Database d) async {}

// Future<List<Food>> getMenu(Database d) async {}

void main() async {
  await get_pranzo();
}
