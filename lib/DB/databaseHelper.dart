import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:reader_tracker/models/book.dart';

class DataBaseHelper {
  static const _dataBaseName = 'books_dataBase.db';
  static const _dataBaseVersion = 1;
  static const _tableName = 'books';

  DataBaseHelper._privateContructor();

  static final DataBaseHelper instance = DataBaseHelper._privateContructor();

  static Database? _dataBase;

  Future<Database> get dataBase async {
    _dataBase ??= await _initDatabase() ;  
    return _dataBase!;
  }

   _initDatabase() async {
    //device/data/datasename.db
    String path = join(await getDatabasesPath(), _dataBaseName);
    return await openDatabase(
      path,
      version: _dataBaseVersion,
      onCreate: _onCreate,
    );
  }

   Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        authors TEXT NOT NULL,
        favorite INTEGER DEFAULT 0,
        publisher TEXT,
        publishedDate TEXT,
        description TEXT,
        industryIdentifiers TEXT,
        pageCount INTEGER,
        language TEXT,
        imageLinks TEXT,
        previewLink TEXT,
        infoLink TEXT
      )
    ''');
  }

  Future<int> insert(Book book) async{
    Database db = await instance.dataBase;
    return await db.insert(_tableName, book.toJson());
  }

  Future<List<Book>> readAllBooks() async {
    Database db = await instance.dataBase;
    var books = await db.query(_tableName);
    return books.isNotEmpty ? books.map((book) => Book.fromJsonDatabase(book)).toList() 
    : [];

  }

}