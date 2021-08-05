import 'package:mongo_dart/mongo_dart.dart';
import 'environment.dart';

class Database {
  String db_endpoint;
  Db db;
  String status = 'closed';

  Database(String db_endpoint) {
    this.db_endpoint = db_endpoint;
    // db = Db('mongodb://$username:$pw@$host:$port/$db_endpoint');
    db = Db('mongodb://$host:$port/$db_endpoint');
  }

  Future open() async {
    print(
        'Opening db connection at $host:$port as $username, reaching Collection:$db_endpoint');
    status = 'open';
    await db.open();
  }

  Future close() async {
    print('Closing db connection...');
    status = 'close';
    await db.close();
    print('Closed!');
  }

  Future collection(String coll) async => db.collection(coll);

  Future find(String c) async => db.collection(c).find();
}
