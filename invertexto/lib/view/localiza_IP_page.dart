import 'package:flutter/material.dart';
import 'package:invertexto/services/invertexto_service.dart';

class LocalizaIPPage extends StatefulWidget {
  const LocalizaIPPage({super.key});

  @override
  State<LocalizaIPPage> createState() => _LocalizaIPPageState();
}

class _LocalizaIPPageState extends State<LocalizaIPPage> {
  String? campo;
  String? cidade;
  String? estado;
  String? codEstado;
  String? pais;
  String? codPais;
  String? continente;
  String? fuso;
  String? latitude;
  String? longitude;
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
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Escreva o IP que quer consultar",
                labelStyle: TextStyle(color: Color.fromARGB(255, 15, 129, 190)),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: localizarIP(campo),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 15, 129, 190)),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError) {
                        return Container();
                      } else
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

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Text(
            snapshot.data["city"] != null
                ? 'Cidade: ${snapshot.data["city"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["state"] != null
                ? 'Estado: ${snapshot.data["state"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["state_code"] != null
                ? 'Código do Estado: ${snapshot.data["state_code"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["country"] != null
                ? 'País: ${snapshot.data["country"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["country_code"] != null
                ? 'Código do País: ${snapshot.data["country_code"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["continent"] != null
                ? 'Continente: ${snapshot.data["continent"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            snapshot.data["time_zone"] != null
                ? 'Fuso Horário: ${snapshot.data["time_zone"]}'
                : '',
            style: TextStyle(
                color: Color.fromARGB(255, 15, 129, 190), fontSize: 18),
          ),
        ],
      ),
    );
  }
}
