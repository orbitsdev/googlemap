import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql ;

class DBHelper{

  static Future<sql.Database> database () async{
    final dbpath =  await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbpath, 'place.db'), onCreate: (db,version){
      return db.execute('CREATE TABLE user_place(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL , address TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table , Map<String , Object> data) async {
    final db =  await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace );
  }

  static Future<List<Map<String, dynamic>>> getdata(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}