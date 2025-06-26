import 'package:flutter/material.dart';
import 'package:reader_tracker/DB/databaseHelper.dart';
import 'package:reader_tracker/Utils/bookDetailsArgument.dart';
import 'package:reader_tracker/models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(future: DataBaseHelper.instance.readAllBooks(),
       builder: (context,snapshot) => 
        snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            Book book = snapshot.data![index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context,'/details',
                arguments: BookDetailsArguments(itemBook: book));
              },
              child: Card(
                child: ListTile(
                  title: Text(book.title),
                  trailing: IconButton(icon: Icon(Icons.delete), onPressed: () { 
                      print('Deleted ${book.id} ');
                      DataBaseHelper.instance.deleteBook(book.id);
                      setState(() {});
                   },),
                  leading: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover,
                  ),
                  subtitle: Column(
                    children: [
                      Text(book.authors.join(", ")),
                      ElevatedButton.icon(onPressed: () async{
                        await DataBaseHelper.instance.toggleFavoriteFlag(book.id, !book.isFavorite)
                        .then((value) => print("Books added to Favorite! $value"),);
                      },icon: Icon(Icons.favorite), label: Text("Favorites"))
                    ],
                  ),
                ),
              ),
            );
          },
        ) : Center(child: const CircularProgressIndicator())),
    );
  }
}