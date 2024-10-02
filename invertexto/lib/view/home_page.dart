import 'package:flutter/material.dart';
import 'package:invertexto/view/busca_cep_page.dart';
import 'package:invertexto/view/localiza_IP_page.dart';
import 'package:invertexto/view/por_extenso_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 144, 195, 244),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/invertexto.png',
              fit: BoxFit.contain,
              height: 40,),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor : Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          GestureDetector(
            child: Row(
              children:<Widget> [
                Icon(Icons.edit, color:  Colors.blue.shade200, size: 70.0),
                Text(
                  "Por Extenso", style: TextStyle(
                    color: Color.fromARGB(255, 15, 129, 190), fontSize: 22.0
                    ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> 
              PorExtensoPage()));
            },
          ),
          GestureDetector(
            child: Row(
              children:<Widget> [
                Icon(Icons.home, color:  Colors.blue.shade200, size: 70.0),
                Text(
                  "Busca CEP", style: TextStyle(
                    color:Color.fromARGB(255, 15, 129, 190), fontSize: 22.0
                    ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> 
              BuscaCepPage()));
            },
          ),
          GestureDetector(
            child: Row(
              children:<Widget> [
                Icon(Icons.room, color:  Colors.blue.shade200, size: 70.0),
                Text(
                  "Busca IP", style: TextStyle(
                    color:Color.fromARGB(255, 15, 129, 190), fontSize: 22.0
                    ),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> 
              LocalizaIPPage()));
            },
          )
        ]), 
      ),
    );
  }
}