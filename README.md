# reader_tracker

# Bottom Navigation Bar
Implements a 3-tab navigation bar:
- 🏠 Home
- 💾 Save
- ❤️ Favourite

```dart
bottomNavigationBar: BottomNavigationBar(
  items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.save), label: "Save"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp), label: "Favourite"),
  ],
)

<BottomNavigationBar> => we explicitly mention that following content is ListType 

- BottomNavigationBar has a lot of propeties , we can use them to style and make bottomNavigationBar functional


factory Book.fromJson(Map<String, dynamic> json) { ... }

- A factory constructor is a special constructor in Dart used when you want to return a custom object, not just assign variables like the usual constructor.


<Future <List<Book>> searchBooks(String query) async 

- You’re creating a function called searchBooks:

- Takes a String query like "flutter"

- Returns a Future of List<Book> (asynchronous response)

-  Meaning: "I'll give you back a list of books... later, after the network call finishes."

Uri.parse() => ensures the string is valid for HTTP calls

await => pauses your function until the response comes back

- `response` => holds all the data, including status code and JSON body

var data = json.decode(response.body);
      var items = data['items'] as List;

      return items.map((item) => Book.fromJson(item)).toList();


 Converts the JSON string response body into a Dart Map

- Now data['items'] will give you a list of books in JSON form.

- Extracts the list of books (JSON format) from the "items" field.

- as List tells Dart: “Yes, this is a list, I know what I’m doing.”

Then:

- Loops through each item in the list

- Converts it into a Book object using your Book.fromJson(...)

- Collects all into a Dart list (toList())

- Returns a fully usable List<Book> back to your app.

```


`static` => eg. If you made 5 Network objects — all of them still point to the same _baseURL. Because static members belong to the class, not to the instance.

# When the widget is first created, initState() runs.
```dart
  - `initState()` =>  perform initial one-time tasks
  - It runs once, automatically, right when your widget is inserted into the widget tree — before the UI is built.
  - Yes — State<MyHomePage> has a built-in initState() method from the Flutter framework.
  - When you write your own, we are overriding it.
  - Then, calling super.initState() lets the original/built-in setup run properly.

 toString() => return a string describing the object , eg. Instance of 'Class' , we can override the toString method!
```

# Routing

```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailsScreen()));
```

# Named Routing 

```dart
initialRoute: '/',
      routes: {
        '/home' : ((context) => HomeScreen()),
        '/saved' : ((context) => SavedScreen()),
        '/favorites' : ((context) => FavoriteScreen()),
        '/details' : ((context) => BookDetailsScreen()),
      },

```

### Arguments in Named routing 

```dart
GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/details',
                      arguments: BookDetailsArgument(itemBook: book));
                    }),

  In Flutter, when navigating using Navigator.pushNamed, we can pass data to the next screen using the arguments parameter. On the destination screen, we retrieve it with ModalRoute.of(context)?.settings.arguments. For clean data transfer, we often wrap this data in a model class like BookDetailsArgument.
```


# Database 

- a structure which allows us to save some SOrt of information



# What is SQFLite?
- It allows us to:

- Store structured data on the user’s device

- Perform `CRUD`: Create, Read, Update, Delete

- Use SQL queries directly inside Flutter apps

- Keep data offline, permanently — even if the app closed

# Path

- The Path platform provides common operation for manipulating paths : joining , splitting , normalizing etc.

# PrivateConstructor

- helps to create instance of a class only under a specific condition such as factory method within a class

- A `private constructor `restricts class instantiation from outside, allowing object creation only from within the class itself — commonly used with factory constructors, singletons, or controlled instance creation.

- Creates   `ONE object of DataBaseHelper`, called instance.

- Prevents creating multiple objects that might create multiple DB connections (which is bad).

- `Private constructor (_privateContructor) ensures no one from outside can create another object using DataBaseHelper().`

# Procedure

- we're creating a custom helper class DataBaseHelper to control and access our local SQLite database only in one way — using SQFLite.

```dart
- class DataBaseHelper {} => we are creating a class to manage all DB operations.

- DataBaseHelper._privateContructor(); -> this make our constructor private , forces singleton

- static final DataBaseHelper instance = DataBaseHelper._privateContructor();
  - singleton Instance => Singleton pattern: one object shared across the app.

  what-s hapning ? 
  - Creates only ONE object of DataBaseHelper, called instance.

  - Prevents creating multiple objects that might create multiple DB connections (which is bad).

  - Private constructor (_privateContructor) ensures no one from outside can create another object using DataBaseHelper().

- static Database? _dataBase;
  - This is the actual sqflite database object — it starts as null.

  - It holds the actual database connection object.

  - static: shared by all objects of the class.

  - Database?: it’s nullable — starts as null.

- Future<Database> get dataBase async {
    _dataBase ??= await _initDatabase() ;  
    return _dataBase!;
  }
  - If _dataBase is null, it initializes it.

  - If already initialized, just returns it.

  - ??= means: if null, assign right side.

  - This ensures lazy loading and single init.

- _initDatabase() async {
    //device/data/datasename.db
    String path = join(await getDatabasesPath(), _dataBaseName);
    return await openDatabase(
      path,
      version: _dataBaseVersion,
      onCreate: _onCreate,
    );
  }

  - 
- getDatabasesPath() is provided by sqflite

It returns the folder path used by Android/iOS to store SQLite file

eg./data/user/0/com.example.reader_tracker/databases

join(await getDatabasesPath(), _dataBaseName);

It becomes:

/data/user/0/com.example.reader_tracker/databases/books_dataBase.db

- openDatabase: Opens or creates the DB at that path.

- onCreate: Triggers when DB is created for first time.
```

# Future builder 

- `snapshot` = Status Report of the Future
- It contains four important things:

- Property	What it tells you
- snapshot.connectionState	Is the future still loading? Done?
- snapshot.hasData	Is there real data in it?
- snapshot.hasError	Did something go wrong?
- snapshot.data	The actual result of your future


