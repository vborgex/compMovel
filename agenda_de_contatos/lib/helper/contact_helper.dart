import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String idColumn = "idColumn";
String nameColumn = "nameColumn";
String emailColumn = "emailColumn";
String phoneColumn = "phoneColumn";
String imgColumn = "imgColumn";
String contactTable =  "contactTable";


class ContactHelper{
  static final  ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();
  Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    // Cria banco se ele não existir ainda
    else{ 
      _db = await initDb();
      return _db;
    }
  }
  // Criando banco
  Future <Database> initDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,"contacts.db");
    return await openDatabase(path, version: 1,onCreate: (Database db, int newVersion) async{
      await db.execute("CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)");      
    });
  }

  Future<List> getAllContacts() async{
    Database dbContact = await this.db;
    // Faz uma lista  com todos os contatos
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    // Faz um for para adicionar  os contatos na lista
    for (Map m in listMap) {
      // Adiciona cada  contato na lista usa o fromMap() para  converter o Map em Contact
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<Contact> getContact(int id) async{
    Database dbContact = await this.db;
    //Faz uma query para buscar o contato com o id
    List<Map> maps = await dbContact.query(contactTable, columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn], where: "$idColumn = ?", whereArgs: [id]);
    // Se  não encontrar contato retorna null
    if(maps.isNotEmpty){
      // Retorna  o contato, sendo  que o contato é um Map
      return Contact.fromMap(maps.first);

    }else{
      return null;
    }
  }

  Future<Contact> saveContact(Contact contact) async {
    // Ve se o banco existe
    Database dbContact = await db;
    // Insere o contato além de pegar o id para o contact, toMap pq para salvar precisa transformar esse Contact
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<int> updateContact (Contact contact) async {
    Database dbContact = await db;
    // A linha  abaixo faz a atualização do contato
    return await dbContact.update(contactTable, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    //A linha de baixo apaga o contato com o id passado; 
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

}

class Contact{
  Contact();
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map){
    id  = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }
  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn : name,
      emailColumn : email,
      phoneColumn : phone,
      imgColumn : img
    };
    if(id !=null){
      map[idColumn] = id;
    }
    return map;
    
  }
  String toString(){
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}
