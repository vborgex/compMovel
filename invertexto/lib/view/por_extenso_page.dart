import 'package:flutter/material.dart';
import 'package:invertexto/services/invertexto_service.dart';

class PorExtensoPage extends StatefulWidget {
  const PorExtensoPage({super.key});

  @override
  State<PorExtensoPage> createState() => _PorExtensoPageState();
}

class _PorExtensoPageState extends State<PorExtensoPage> {
  String? campo;
  String? resultado;
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
                labelText: "Digite um número inteiro",
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
                future: converterNumeroPorExtenso(campo),
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
        child: TextField(
          decoration: InputDecoration(
            labelText: snapshot.data["text"],
            labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color:Color.fromARGB(255, 15, 129, 190),fontSize:18),
        ),
      );

    }
}