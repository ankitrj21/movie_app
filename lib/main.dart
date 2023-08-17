import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movies_Widget.dart';


void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override 
  _App createState() => _App(); 
}

class _App extends State<App> {

  List<Movie> _movies = List<Movie>.empty();
  List<Movie> _topmovies = List<Movie>.empty();
  int _count = 0;
  
  String selectedFilter = 'ratings';
  @override
  void initState() {
    super.initState(); 
    _populateAllMovies('ratings'); 
  }

  void _populateAllMovies(filter) async {
    final movies = await _fetchAllMovies(filter, 1);
    setState(() {
      _movies = movies;
      _count =  5;
      _topmovies = movies.sublist(0, _count);
    });
  }

  Future<void> _increaseCount() async {

    setState(() {
      _count = _count + 5;
      if(_count <= _movies.length) { 
      _topmovies = _movies.sublist(0, _count);
      }
    });
      if(_count % 20 == 0 && _count > 0) {
        final page = (_count/20) + 1;
        final movies = await _fetchAllMovies(selectedFilter, page);

        setState(() {
          _movies.addAll(movies);
         // _count =  _count;
          _topmovies = (movies.sublist(0, 5));
        });
    }
  }

  Future<List<Movie>> _fetchAllMovies(filterOptions, page) async {
    final filter = filterOptions == 'ratings'
        ? 'vote_average.desc'
        : filterOptions == 'year'
            ? 'primary_release_date.desc'
            : filterOptions == 'popularity'
                ? 'popularity.desc'
                : 'popularity.desc'; 
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/discover/movie?sort_by=$filter&vote_count.gte=250&api_key=c60ea716c15059040ae71f7b4fb90b68&page=$page"));

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
    

      Iterable list = result["results"];
      return list.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Failed to load movies!");
     }
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: MoviesWidget(movies: _topmovies, populateAllMovies: _populateAllMovies, increaseCount: _increaseCount),
      ),
    );
  }
}