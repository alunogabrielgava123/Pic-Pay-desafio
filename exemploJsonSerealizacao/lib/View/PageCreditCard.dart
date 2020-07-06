import 'package:exemploJsonSerealizacao/Controller/Card_cadastro_controller.dart';
import 'package:exemploJsonSerealizacao/Data/CardHelper.dart';
import 'package:exemploJsonSerealizacao/View/Transicao/PageTransicap.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CraditCardPage extends StatefulWidget {
  @override
  _CraditCardPageState createState() => _CraditCardPageState();
}

class _CraditCardPageState extends State<CraditCardPage> {
  FocusNode _focusNodeCartao;
  FocusNode _focusNodeNomeTitula;
  FocusNode _focusVencimento;
  FocusNode _focusNodeCvv;
  bool _loading;

  //instanciando helper
  DataHelper helper = DataHelper();

  @override
  void initState() {
    _focusNodeCartao = FocusNode();
    _focusNodeNomeTitula = FocusNode();
    _focusVencimento = FocusNode();
    _focusNodeCvv = FocusNode();
    _loading = false;
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeCartao.dispose();
    _focusNodeNomeTitula.dispose();
    _focusVencimento.dispose();
    _focusNodeCvv.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodeCartao);
    });
  }

  void _requestFocusTitular() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodeNomeTitula);
    });
  }

  void _requestFocusVencimento() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusVencimento);
    });
  }

  void _requestFocusCvv() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodeCvv);
    });
  }

  final controllerNumeroCarto = TextEditingController();
  final controllerNomeTitular = TextEditingController();
  final controllerVencimento = TextEditingController();
  final controllerCvv = TextEditingController();

  TextField _textCartao({myFocusNode, request, title, controller}) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      focusNode: myFocusNode,
      cursorColor: Colors.lightGreen,
      style: TextStyle(color: Colors.white),
      onTap: request,
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen)),
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.lightGreen : Colors.grey,
              fontSize: 25),
          labelText: title,
          hintStyle: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }

  Container _getLoading(context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controllerCadastro = Provider.of<CardController>(context);
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Container(
                  child: Text(
                    "Cadastrar cartão",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 120,
                        child: _textCartao(
                            myFocusNode: _focusNodeCartao,
                            request: _requestFocus,
                            title: "Numero do Cartao",
                            controller: controllerNumeroCarto),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 120,
                        child: _textCartao(
                            myFocusNode: _focusNodeNomeTitula,
                            request: _requestFocusTitular,
                            title: "Nome do titular",
                            controller: controllerNomeTitular),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Container(
                          height: 120,
                          child: _textCartao(
                              myFocusNode: _focusVencimento,
                              title: "Vencimento",
                              request: _requestFocusVencimento,
                              controller: controllerVencimento),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        child: _textCartao(
                            myFocusNode: _focusNodeCvv,
                            title: "CVV",
                            request: _requestFocusCvv,
                            controller: controllerCvv),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 320,
                    height: 45,
                    child: RaisedButton(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)),
                        onPressed: () {
                          controllerCadastro
                              .setNumberCard(controllerNumeroCarto.text);

                          helper.saveCard(CartaoDeCredito(
                              number: controllerNumeroCarto.text,
                              name: controllerNomeTitular.text,
                              vencimento: controllerVencimento.text,
                              cvv: controllerCvv.text));
                          
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (contex) => PageTransicao()));
                        },
                        child: Text(
                          "Salvar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
