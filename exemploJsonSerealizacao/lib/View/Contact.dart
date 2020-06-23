import 'package:exemploJsonSerealizacao/Data/Users.dart';
import 'package:exemploJsonSerealizacao/Model/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ContactUsers extends StatefulWidget {
  ContactUsers({Key key, this.title}) : super(key: key);
  //inicial class atributos about this view
  final String title;

  @override
  _ContactUsersState createState() => _ContactUsersState();
}

class _ContactUsersState extends State<ContactUsers> {
  List<User> _users;
  bool _loading;

  void _getUsers() async {
    await Service.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getUsers();
  }

  Container _getListCardUser(User user) {
    return Container(
      color: Color.fromRGBO(27, 21, 21, 1),
      child: Card(
        elevation: 0.0,
        color: Color.fromRGBO(27, 21, 21, 1),
        child: ListTile(
          onTap: () {
            print("clicado");
          },
          title: _getTextUserTile(color: Colors.white, user: user.username),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.img),
            maxRadius: 25,
          ),
          subtitle: _getTextUserTile(color: Colors.grey, user: user.name),
        ),
      ),
    );
  }

  Text _getTextUserTile({Color color, String user}) {
    return Text(
      user,
      style: TextStyle(color: color, fontSize: 16),
    );
  }

  //RETURNE A TREE OF COMPONENTES IN THE PAGE
  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(27, 21, 21, 1);
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
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "A quem voce deseja pagar?",
                            hintStyle: TextStyle(color: Colors.white),
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
                      return _getListCardUser(user);
                    }, childCount: _users.length),
                  )),
            ],
          );
  }
}
