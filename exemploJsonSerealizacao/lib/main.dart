
import 'package:exemploJsonSerealizacao/Controller/Card_cadastro_controller.dart';
import 'package:exemploJsonSerealizacao/Controller/User_controller.dart';
import 'package:exemploJsonSerealizacao/View/Contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        //add anymore provider in the list of provider
        create:  (context)=> ControllerProvaider()),
      ChangeNotifierProvider(
        create: (context)=> CardController(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactUsers(
        title: "Contatos",
      ),
    );
  }
}
