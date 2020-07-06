import 'package:exemploJsonSerealizacao/Controller/Card_cadastro_controller.dart';
import 'package:exemploJsonSerealizacao/Controller/User_controller.dart';
import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PagePagamento extends StatefulWidget {
  PagePagamento({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _PagePagamentoState createState() => _PagePagamentoState();
}

class _PagePagamentoState extends State<PagePagamento> {
  String _text = "0,00";
  


  @override
  Widget build(BuildContext context) {
    final controllerCard = Provider.of<CardController>(context);

    return Container(
        child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Container(
                  child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.img),
                radius: 45,
              )),
              SizedBox(
                height: 20,
              ),
              Text(widget.user.username,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text("R\$  ",
                      style:GoogleFonts.roboto(color:Colors.grey, fontSize: 35, fontWeight: FontWeight.w300)),
                  Text("$_text",
                      style:GoogleFonts.roboto(color:Colors.grey, fontSize: 70, fontWeight: FontWeight.w300))
                ],
              ),
              SizedBox(
                height: 55,
              ),
              Text("Master Card ${controllerCard.numero?? "Desenvolvendo"}",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              SizedBox(
                height: 150,
              ),
              Container(
                width: 300,
                height: 45,
                child: RaisedButton(
                    autofocus: true,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    onPressed: () {},
                    child: Text(
                      "Pagar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
