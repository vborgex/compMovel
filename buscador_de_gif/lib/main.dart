import 'package:buscador_de_gif/view/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Color.fromARGB(255, 241, 242, 246)),
    debugShowCheckedModeBanner: false,
  ));
}
