import 'package:flutter/material.dart';
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


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}