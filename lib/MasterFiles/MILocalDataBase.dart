import 'MasterConstant.dart';
import 'package:sqflite/sqflite.dart';

const DATABASENAME = "DEMO.db";

class MILocalDataBase {
  static final MILocalDataBase shared = MILocalDataBase._internal();

  Database database;

  static MILocalDataBase get() {
    return shared;
  }

  MILocalDataBase._internal();

  Future init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASENAME);

    database = await openDatabase(path, version: 1);

//    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async{
//      await db.execute("");
//    });
  }

  void createTable(String tableName, Map<String, String> tblColumn) async {
//    "CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");

    if (database != null) {
      await database.transaction((txn) {
        String strQuery = "";

        String strColumn = "";
        tblColumn.forEach((column, type) {
          strColumn =
              strColumn.isEmpty ? "$column $type" : "$strColumn, $column $type";
        });

        print("strColumn =============== $strColumn");
        strQuery = "CREATE TABLE IF NOT EXISTS $tableName ($strColumn)";
        print("strQuery =============== $strQuery");

        txn.execute(strQuery);
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllObject(String tableName) async {
    List<Map> list = await database.rawQuery("SELECT * FROM $tableName");
    print("FetchAllObject ======== $list");
    return list;
  }


}
