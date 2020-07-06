
import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


class ControllerProvaider extends ChangeNotifier {

  List<User> _listUser = [];
  List<User> _newListBusca;

  void setListUser(value) {
    _listUser = value;
    notifyListeners();
  }

  List<User> getListUser() {
    return _listUser;
  }

  void serarch(value) {
    var seach = _listUser
        .where((element) => element.name.toLowerCase().startsWith(value))
        .toList();
    _newListBusca = seach;
    notifyListeners();
  }

  List<User> get newListaBusca => _newListBusca;


}







//  Future<List<User>> getFutereUser() async{
//    var data = await http.get("http://careers.picpay.com/tests/mobdev/users");
//    var jsonData = json.decode(data.body);
//    for( var u in jsonData){
//      User user = User(username:u["username"], name: u["name"], img:u["img"], id: u["id"]);
//      _listFutureUser.add(user);
//      print(_listFutureUser.length);
//    }
//    return _listFutureUser;
//  }