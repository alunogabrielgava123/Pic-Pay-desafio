

import 'package:exemploJsonSerealizacao/Data/CardHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageCartaoDeCredito extends StatefulWidget {
  PageCartaoDeCredito({Key key}) : super(key: key);

  @override
  _PageCartaoDeCreditoState createState() => _PageCartaoDeCreditoState();
}

class _PageCartaoDeCreditoState extends State<PageCartaoDeCredito> {
  DataHelper helper = DataHelper();
  List<CartaoDeCredito> _listaDeCartao = [];

  @override
  void initState() {
    super.initState();
    helper.getAllCard().then((lista) {
      setState(() {
        _listaDeCartao = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
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
      ),
      body: FutureBuilder(
        future: helper.getAllCard(),
        builder: (context, snapshot) {
          final cartao = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: _listaDeCartao.length,
                itemBuilder: (context, index) {
                  return ListeBilder(cartaoDeCredito: cartao[index]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ListeBilder extends StatelessWidget {
  const ListeBilder({Key key, this.cartaoDeCredito}) : super(key: key);

  final CartaoDeCredito cartaoDeCredito;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        trailing: IconButton(
          icon: Icon(Icons.cancel , color: Colors.grey,),
          onPressed: (){
            showDialog(context: 
            context, 
            builder:(context){
            return   AlertDialog(
                title: Text("Voce deseja Deletar"),
                actions: <Widget>[
                  RaisedButton(
                    child: Text("sim"),
                    onPressed: (){},
                  ),
                  RaisedButton(
                    child: Text("Nao"),
                    onPressed: (){

                    },
                  )
                ],
              );
            }
            );
          },
        ),
        subtitle: Text(
            cartaoDeCredito.name, 
            style: GoogleFonts.roboto(
                color: Colors.grey, fontWeight: FontWeight.w200)),
        title: Text(
          " ***** **** **** ${cartaoDeCredito.number.substring(cartaoDeCredito.number.length - 3)}",
          style: GoogleFonts.roboto(color: Colors.red),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(
            Icons.credit_card,
            color: Colors.green,
          ),
        ));
  }
}
