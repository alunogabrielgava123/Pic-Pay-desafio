import 'package:flutter/cupertino.dart';

class CardController extends ChangeNotifier {
  String _numberCard;
  String _name;
  String _vencimento;
  String _cvv;

  void setNumberCard(number){
    _numberCard = number;
    notifyListeners();
  }

  void setName(titular){
    _name = titular;
    notifyListeners();
  }

  void setVencimento(vencimento){
    _vencimento = vencimento;
    notifyListeners();
  }

  void setCvv(cvv){
    _cvv = cvv;
    notifyListeners();
  }



  String get numero => _numberCard;

  String get titular => _name;

  String get vencimento => _vencimento;

  String get cvv => _cvv;

}
