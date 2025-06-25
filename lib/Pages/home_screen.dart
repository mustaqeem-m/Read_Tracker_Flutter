import 'package:flutter/material.dart';
import 'package:reader_tracker/Components/grifViewWidget.dart';
import 'package:reader_tracker/Network/network.dart';
import 'package:reader_tracker/models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Network network = Network();
  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    try{
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
      // print("Books: ${books.toString()}");
    }
    catch(e) {
      throw Exception("Failed to load Books $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding( 
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Atomic Habits",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )
                ),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),

            GridViewWidget(books: _books)
          ],
        ),
      ),
    );
  }
}


