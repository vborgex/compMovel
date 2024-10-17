import 'dart:io';

import 'package:agenda_de_contatos/helper/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();
  

  @override
  void initState() {

    super.initState();

    Contact c = Contact();
    c.name = "Vanessa";
    c.email = "vanessa@gmail.com";
    c.phone = "1234567890";
    c.img = null;
    helper.saveContact(c);
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });

      print(list);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda de contatos"),
        backgroundColor: Color.fromARGB(255, 30, 70, 121),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 198, 208, 229),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          
        }),
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 30, 70, 121)),
      body: ListView.builder(
        //Criando uma lista de contatos,  e cada contato é uma linha da lista
        padding: const EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return contactCard(context, index);
        },
      ),
    );
  }

  Widget contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ? FileImage(File(contacts[index].img)) : const AssetImage("assets/imgs/pfpdefault.jpg"),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      contacts[index].name ?? "", 
                      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)
                    ),
                    Text(
                      contacts[index].email ?? "", 
                      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal)
                    ),
                    Text(
                      contacts[index].phone ?? "", 
                      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
