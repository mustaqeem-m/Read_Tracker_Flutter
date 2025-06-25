import 'package:flutter/material.dart';
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

            Expanded(child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: _books.length,
              itemBuilder: (context, index) {
                Book book = _books[index];
                return Container(
                  margin: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Image.network(book.imageLinks['thumbnail'] ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(book.title,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          ),
                        ),
                      ),
                      Text(book.authors.join(', '),
                      overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                );
              },
            ),)
            // Expanded(
            //   child: Container(
            //     width: double.infinity,
            //     child: ListView.builder(
            //       itemCount: _books.length,
            //       itemBuilder: (context, index) {
            //         Book book = _books[index];
            //         return ListTile(
            //           title: Text(book.title),
            //           subtitle: Text(book.authors.join(", ")),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}