import "package:reader_tracker/models/book.dart";
import 'dart:convert';
import "package:http/http.dart" as http;

class Network {

  static const String _baseURL = "https://www.googleapis.com/books/v1/volumes";

  Future <List<Book>> searchBooks(String query) async {
    var url = Uri.parse("$_baseURL?q=$query");
    var response = await http.get(url);

    if (response.statusCode == 200){
      var data = json.decode(response.body);

      if (data['items'] != null && data['items'] is List) {
        List<Book> books = (data['items'] as List<dynamic>)
          .map((book) => Book.fromJson(book as Map<String, dynamic>)) 
          .toList();
        return books;
      }else{
        return [];
      }

    }
    else{
      throw Exception("Failed to load books");
    }
  }
}