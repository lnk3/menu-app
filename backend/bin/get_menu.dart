import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'dart:convert';

void main() async {
  var response = fetchData(http.Client());
  print(response);
}

Future<List<Food>> fetchData(http.Client client) async {
  // Endpoint from where we get list of food
  var url = Uri.parse(Platform.environment['API']);

  // Request header
  var headersList = {
    'Accept': '*/*',
    'Authorization': 'Bearer ${Platform.environment['TOKEN']}'
  };

  // Request body
  var body = {
    'action': 'getMenu', // API defined action
    'date': getToday(), // Return string in format AAAA-MM-DD
    'time': (DateTime.now().hour < 19
        ? '0'
        : '1') // Return 0 before dinner and 1 after dinner
  };

  // Http request to the API
  final response = await client.post(url, body: body, headers: headersList);

  // // If the response is 200 and the is a menu for the day get the list of foods, if not check if date is out of range
  // if (await response.body['actionStatus'] == 200 && !(await response['menu'].isEmpty)) {
  // } else if (await msg['actionMessage'] == 'date out of range') {
  // print('Date out of range');
  // } else {
  // print('Error');
  // }

  return parseData(response.body);
}

String getToday() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd');
  final formatted = formatter.format(now);
  return formatted;
}

class Food {
  final int id;
  final String name;
  final String type;

  Food({this.id, this.name, this.type});

  @override
  String toString() => '$name - $id ($type)';

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['meal_id'] as int,
      name: json['meal'] as String,
      type: json['meal_type'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
      };
}

List<Food> parseData(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List<dynamic>).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}

List<Food> itemFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String itemToJson(List<Food> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
