import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:http/http.dart' as http;

class Service {
  static const String url = "http://careers.picpay.com/tests/mobdev/users";
  static Future<List<User>> getUsers() async {
    try {
      final reponse = await http.get(url);
      if (200 == reponse.statusCode) {
        final List<User> users = usersFromJson(reponse.body);
        return users;
      } else {
        return List<User>();
      }
    } catch (e) {
      
    }
  }
}
