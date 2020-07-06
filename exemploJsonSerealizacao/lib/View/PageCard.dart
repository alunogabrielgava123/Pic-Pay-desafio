import 'package:exemploJsonSerealizacao/Controller/Card_cadastro_controller.dart';
import 'package:exemploJsonSerealizacao/Data/CardHelper.dart';
import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:exemploJsonSerealizacao/View/Pagamento/Pagamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PageCreditCard.dart';

class PageCard extends StatefulWidget {
  final User user;

  PageCard(this.user);

  @override
  _PageCardState createState() => _PageCardState();
}

class _PageCardState extends State<PageCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  
  DataHelper helper = DataHelper();
  List<CartaoDeCredito> listaDeCartao = [];
  

  
  
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    helper.getAllCard().then((lista){
      setState(() {
        listaDeCartao = lista;
        getCartao();
      });
    });
  }

 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
   bool _isCard = false;


   

 void getCartao(){
   if( listaDeCartao.length != 0 && listaDeCartao != null){
     _isCard = true;
   }else{
    _isCard = false;
   }
 }
   

  @override
  Widget build(BuildContext context) {
    return _isCard ? PagePagamento(user: widget.user,) : Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.green,
              size: 45,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Container(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: AssetImage("assets/credit-card.png"),
                  ),
                ),
                Container(
                  child: Text(
                    "Cadastre um cartão",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    "de crédito",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 110,
                ),
                SafeArea(
                  child: Container(
                    width: 350,
                    height: 45,
                    child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (contex) => CraditCardPage()));
                          print("nao sou um botao");
                        },
                        child: Text(
                          "Cadastrar cartão",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
