import 'package:exemploJsonSerealizacao/Controller/Card_cadastro_controller.dart';
import 'package:exemploJsonSerealizacao/View/Contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageCheckCadastro extends StatelessWidget {
  const PageCheckCadastro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerNameCartao = Provider.of<CardController>(context);
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 185,
            ),
            Container(
              height: 200,
              child: Image(
                image: AssetImage("assets/card-2.png"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Cartao Cadastrado com sucesso!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${controllerNameCartao.numero}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (contex) => ContactUsers()));
                },
                child: Text(
                  "Continuar Pagamento",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        )
      ],
    );
  }
}
