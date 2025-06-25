import 'package:flutter/material.dart';
import 'package:reader_tracker/Network/network.dart';
import 'package:reader_tracker/Pages/book_details.dart';
import 'package:reader_tracker/Pages/favorite_screen.dart';
import 'package:reader_tracker/Pages/home_screen.dart';
import 'package:reader_tracker/Pages/saved_screen.dart';
import 'package:reader_tracker/models/book.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      initialRoute: '/',
      routes: {
        '/home' : ((context) => HomeScreen()),
        '/saved' : ((context) => SavedScreen()),
        '/favorites' : ((context) => FavoriteScreen()),
        '/details' : ((context) => BookDetailsScreen())
      },
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  

  final List <Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoriteScreen(),
  ]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Reader-1",
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, //getting currentIndex
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: const<BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home")  ,
        BottomNavigationBarItem(icon: Icon(Icons.save), label: "Save"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_sharp), label:"Favorite"),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,

        onTap: (value) {
          print("Tapped: $value");
          setState(() {
            _currentIndex = value; //Setting CurrentIndex
          });
          print('Tapped CurrentIndex: $_currentIndex');
        },
        )
  );
  }
}