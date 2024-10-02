import 'package:flutter/material.dart';
import 'package:invertexto/services/invertexto_service.dart';

class BuscaCepPage extends StatefulWidget {
  const BuscaCepPage({super.key});

  @override
  State<BuscaCepPage> createState() => _BuscaCepPageState();
}

class _BuscaCepPageState extends State<BuscaCepPage> {
  String? campo;
  String? cep;
  String? estado;
  String? cidade;
  String? bairro;
  String? rua;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children:<Widget> [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Digite um CEP",
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: buscaCep(campo),
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                          width: 200.0,
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 15, 129, 190)),
                            strokeWidth: 5.0,
                          ),
                      );
                    default:
                      if (snapshot.hasError){
                        return Container();
                      }
                      else 
                        return exibeResultado(context, snapshot);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget exibeResultado (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.only(top: 10.0),
        child:Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: snapshot.data["cep"],
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: snapshot.data["state"],
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: snapshot.data["city"],
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: snapshot.data["neighborhood"],
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: snapshot.data["street"],
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
            ),
          ],
        ), 
      );

    }
}