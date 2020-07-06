import 'package:exemploJsonSerealizacao/View/Contact.dart';
import 'package:exemploJsonSerealizacao/View/Transicao/componenteCheck.dart';
import 'package:flutter/material.dart';

class PageTransicao extends StatefulWidget {
  PageTransicao({Key key}) : super(key: key);

  @override
  _PageTransicaoState createState() => _PageTransicaoState();
}

class _PageTransicaoState extends State<PageTransicao> {



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageCheckCadastro(),
    );
  }
}
