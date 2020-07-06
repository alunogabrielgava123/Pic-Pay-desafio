import 'package:exemploJsonSerealizacao/Controller/User_controller.dart';
import 'package:exemploJsonSerealizacao/Data/CardHelper.dart';

import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:exemploJsonSerealizacao/Model/Model.dart';
import 'package:exemploJsonSerealizacao/View/ListaCartao/PageListaCartao.dart';
import 'package:exemploJsonSerealizacao/View/PageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

class ContactUsers extends StatefulWidget {
  ContactUsers({Key key, this.title}) : super(key: key);

  //inicial class atributos about this view
  final String title;

  @override
  _ContactUsersState createState() => _ContactUsersState();
}

class _ContactUsersState extends State<ContactUsers> {
  List<User> _users;

  final helper = DataHelper();

  void getUserProvaider() {
    final controller = Provider.of<ControllerProvaider>(context, listen: false);
    PicPay.getUsers().then((user) {
      setState(() {
        controller.setListUser(user);
        _users = controller.getListUser();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserProvaider();
    helper.getAllCard().then((list){
       print(list);
    });  
    
  }

  Container _getListCardUser(
    user,
    contex,
  ) {
    return Container(
      color: Colors.black,
      child: Card(
        elevation: 0.0,
        color: Colors.black,
        child: ListTile(
          onTap: () {
            Navigator.push(contex,
                new MaterialPageRoute(builder: (contex) => PageCard(user)));
          },
          title: _getTextUserTiles(color: Colors.white, user: user.username),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.img),
            maxRadius: 25,
          ),
          subtitle: _getTextUserTiles(color: Colors.grey, user: user.name),
        ),
      ),
    );
  }

  Text _getTextUserTiles({Color color, String user}) {
    return Text(
      user,
      style: TextStyle(color: color, fontSize: 16),
    );
  }

  //RETURNE A TREE OF COMPONENTES IN THE PAGE
  @override
  Widget build(BuildContext context) {
    const color = Colors.black;
    final controller = Provider.of<ControllerProvaider>(context);
    return _users == null
        ? Center(
            child: Container(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
            ),
          )
        : CustomScrollView(
            slivers: <Widget>[
              SliverSafeArea(
                top: false,
                bottom: false,
                sliver: SliverAppBar(
                  pinned: true,
                  expandedHeight: 120,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.call_to_action,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PageCartaoDeCredito(),
                        ));
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    background: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 90,
                          left: 20,
                          child: Text(
                            "Contatos",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    titlePadding: EdgeInsets.all(13),
                  ),
                  elevation: 0.0,
                  floating: false,
                  backgroundColor: color,
                  leading: Icon(Icons.person),
                ),
              ),
              SliverStickyHeader(
                  header: Container(
                      height: 65,
                      color: color,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: color,
                        child: TextField(
                          onTap: () {},
                          onChanged: (value) {
                            controller.serarch(value);
                            _users = controller.newListaBusca;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "A quem voce deseja pagar?",
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.brown,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey[500]),
                            ),
                          ),
                        ),
                      )),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      User user = _users[index];
                      return _getListCardUser(user, context);
                    }, childCount: _users.length),
                  )),
            ],
          );
  }
}
