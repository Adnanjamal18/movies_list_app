import 'package:flutter/material.dart';
import 'package:movies_list_app/modals/moviesmodal.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
class MovieProvider with ChangeNotifier {
  final Box _movieBox = Hive.box('moviesBox');

  List<Movie> get movies {
    return _movieBox.values.map((data) {
      final movieMap = data as Map;
      return Movie(
        name: movieMap['name'],
        director: movieMap['director'],
        poster: File(movieMap['posterPath']),
      );
    }).toList();
  }

  void addMovie(Movie movie) {
    _movieBox.add({
      'name': movie.name,
      'director': movie.director,
      'posterPath': movie.poster.path,
    });
    notifyListeners();
  }

  void deleteMovie(int index) {
    _movieBox.deleteAt(index);
    notifyListeners();
  }
}
