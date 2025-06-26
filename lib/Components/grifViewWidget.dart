import 'package:flutter/material.dart';
import 'package:reader_tracker/Utils/bookDetailsArgument.dart';
import 'package:reader_tracker/models/book.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GridView.builder(
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
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details',
              arguments: BookDetailsArguments(itemBook: book, isFromSavedScreen: false));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Image.network(book.imageLinks['thumbnail'] ?? '',
                  scale: 1.4,),
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
          ),
        );
      },
    ),
    );
  }
}
