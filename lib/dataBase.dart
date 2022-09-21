import 'package:basic_banking_app/dataUsed/allcustomers_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlDb {
  static Database? _db;

  Future<Database?> get dataBase async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databaspath = await getDatabasesPath();
    String path = join(databaspath, "dataBase_basicBanking");
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _oncreate,
    );
    return database;
  }

  _oncreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE customers(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          balance INT NOT NULL
          )  
''');
    batch.execute('''
        CREATE TABLE transcations(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          sender TEXT NOT NULL,
          reciever TEXT NOT NULL,
          amount INT NOT NULL)''');
    await batch.commit();
    for (int i = 0; i < allcustomers.length; i++) {
      db.insert("customers", allcustomers[i]);
    }
  }

  Future read(String table) async {
    Database? database = await dataBase;
    List<Map> response = await database!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? database = await dataBase;
    int response = await database!.insert(table, values);
    return response;
  }

  update(
    String table,
    Map<String, Object?> values,
    String? where,
  ) async {
    Database? database = await dataBase;
    int response = await database!.update(table, values, where: where);
    return response;
  }

  delete(String table, String? where) async {
    Database? database = await dataBase;
    int response = await database!.delete(table, where: where);
    return response;
  }
}
