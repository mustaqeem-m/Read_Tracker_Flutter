import 'package:flutter/material.dart';
import 'package:reader_tracker/DB/databaseHelper.dart';
import 'package:reader_tracker/Utils/bookDetailsArgument.dart';
import 'package:reader_tracker/models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as BookDetailsArguments; 
    final Book book = args.itemBook;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),  
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if(book.imageLinks.isNotEmpty)
              Padding(padding: const EdgeInsets.all(18.0),
              child: Image.network(book.imageLinks['thumbnail'] ?? '',
              fit: BoxFit.cover,)
              ),
              Column(
                children: [
                  Text(book.title,
                  style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                  Text(book.authors.join(', '),
                  style: theme.textTheme.labelLarge,),
                  SizedBox(height: 10,),
                  Text("Published: ${book.publishedDate}",
                  style: theme.textTheme.bodyMedium),
                  SizedBox(height: 10,),
                  Text("PageCount: ${book.pageCount}",
                  style: theme.textTheme.bodySmall,),
                  SizedBox(height: 10,),
                  Text("Language: ${book.language}",
                  style: theme.textTheme.bodySmall,),
                  SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(onPressed: () async{
                      try{
                        int savedInt = await DataBaseHelper.instance.insert(book);
                        SnackBar snackBar = SnackBar(
                          content: Text("Book Saved $savedInt") 
                        );
                        ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                      }catch(e){
                        print("Error $e");
                      }
                    }, 
                    icon: Icon(Icons.save),
                    label:  Text("Save")),
                    ElevatedButton.icon(onPressed: () async{
                      try{
                        await DataBaseHelper.instance.readAllBooks()
                        .then((books) => {
                          for (var book in books ){
                            print("Title: ${book.title}")
                          }
                        });
                      }catch(e){
                        print("error $e");
                      }
                    }, 
                    icon: Icon(Icons.favorite),
                    label:  Text("Favorite")),
                  ],
                ),
                SizedBox(height: 20,),
                Text("Description",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: theme.colorScheme.secondary
                    )
                  ),
                  child: Text(book.description,
                  style: theme.textTheme.labelLarge),
                )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}