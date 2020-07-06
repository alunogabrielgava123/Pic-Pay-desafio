import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String cardTable = "cardTable";
final String idColumn = "idColumn";
final String numberColumn = "numberColumn";
final String nameColumn = "nameColumn";
final String vencimenroColumn = "vencimenroColumn";
final String cvvColumn = "vencimenroColun";

class DataHelper {
  static final DataHelper _instance = DataHelper.internal();

  factory DataHelper() => _instance;

  DataHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "card.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $cardTable($idColumn INTEGER PRIMARY KEY , $numberColumn TEXT, $nameColumn TEXT, $vencimenroColumn TEXT, $cvvColumn TEXT)");
    });
  }

  Future<CartaoDeCredito> saveCard(CartaoDeCredito card) async {
    Database dbCard = await db;
    card.id = await dbCard.insert(cardTable, card.toMap());
    return card;
  }

  Future<CartaoDeCredito> getCard(int id) async {
    Database dbCard = await db;
    List<Map> maps = await dbCard.query(cardTable,
        columns: [
          idColumn,
          numberColumn,
          nameColumn,
          vencimenroColumn,
          cvvColumn
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return CartaoDeCredito.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCard(int id) async {
    Database dbCard = await db;
    return await dbCard
        .delete(cardTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateCard(CartaoDeCredito card) async {
    Database dbCard = await db;
    return await dbCard.update(cardTable, card.toMap(),
        where: "$idColumn = ? ", whereArgs: [card.id]);
  }

    Future<List<CartaoDeCredito>> getAllCard()async{
    Database dbCard = await db;
    List listMap = await dbCard.rawQuery("SELECT * FROM $cardTable");
    List<CartaoDeCredito> listCard = List();
    for(Map m in listMap){
      listCard.add(CartaoDeCredito.fromMap(m));
    }
    return listCard;
  }

  Future<int> getNumber()async{
    Database dbCard = await db;
    return Sqflite.firstIntValue(await dbCard.rawQuery("SELECT COUNT(*) FROM $cardTable"));
     
  }
  Future close() async{
    Database dbCard = await db;
    dbCard.close();
  }

}

class CartaoDeCredito {
  int id;
  String number;
  String name;
  String vencimento;
  String cvv;

  CartaoDeCredito({this.number, this.name, this.vencimento, this.cvv, this.id});

  CartaoDeCredito.fromMap(Map map) {
    id = map[idColumn];
    number = map[numberColumn];
    name = map[nameColumn];
    vencimento = map[vencimenroColumn];
    cvv = map[cvvColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      numberColumn: number,
      nameColumn: name,
      vencimenroColumn: vencimento,
      cvvColumn: cvv
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Card(id:$id,number:$number, name: $name, vencimento:$vencimento , cvv:$cvv)";
  }
}
