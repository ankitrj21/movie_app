
class Movie{
  final String title;
  final String poster;
  final String year;
  final double rating;
  final double popularity;


  Movie({required this.title, required this.poster, required this.year, required this.rating, required this.popularity});
   
   factory Movie.fromJson(Map<String, dynamic> json) {
    
    return Movie(
      title: json["title"],
      poster: json["poster_path"],
      year: json["release_date"].substring(0,4),
      rating: json["vote_average"],
      popularity: json["popularity"],

    );
   }
}
//"adult": false,
//"backdrop_path": "/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg",
//"genre_ids": [
//18,
//80
//],
//"id": 238,
//"original_language": "en",
//"original_title": "The Godfather",
//"overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
//"popularity": 125.425,
//"poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
//"release_date": "1972-03-14",
//"title": "The Godfather",
//"video": false,
//"vote_average": 8.7,
//"vote_count": 18410