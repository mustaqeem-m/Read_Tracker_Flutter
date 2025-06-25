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





