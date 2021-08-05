import 'dart:io' show Platform;
import 'get_menu.dart';
import 'dart:async';
import 'database.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'environment.dart';

Future<Database> start_menu() async {
  var db_conn = Database('menu');
  await db_conn.open();
  return db_conn;
}

addMeals(List<Food> f, Database d) async {}

deleteAllMeals(Database d) async {}

Future<List<Food>> getMenu(Database d) async {}

void main() async {
  var db = await start_menu();
  var menu_pranzo = await db.find('pranzo').toList();
  print(menu_pranzo.toString());
}
