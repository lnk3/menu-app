import 'dart:io' show Platform;

String host = Platform.environment['MONGO_HOST'] ?? '127.0.0.1';
String port = Platform.environment['MONGO_PORT'] ?? '27017';
String username = Platform.environment['MONGO_INITDB_ROOT_USERNAME'] ?? '27017';
String pw = Platform.environment['MONGO_INITDB_ROOT_PASSWORD'] ?? '27017';
