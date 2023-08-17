import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class MoviesWidget extends StatefulWidget {
  final List<Movie> movies;
  final ValueChanged<String> populateAllMovies;
  final Function increaseCount;
  

  const MoviesWidget({Key? key, required this.movies, required this.populateAllMovies, required this.increaseCount}) : super(key: key);

  @override
  MoviesWidgetState createState() => MoviesWidgetState();
}

class MoviesWidgetState extends State<MoviesWidget> {

  int selectedMovieIndex = -1;
  late String selectedFilter = 'ratings';

  final controller = ScrollController();
  List<String> items = [];
  int page = 1;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }
  // @override
  // void dispose() {
  //   controller.dispose();
  // }

  Future fetch() async {
    await widget.increaseCount();
    setState(() {     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Movie Filters'),
      // ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFilter = newValue;
                  });
                 
                  widget.populateAllMovies(newValue);
                }
              },
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  value: 'ratings',
                  child: Text('Ratings'),
                ),
                DropdownMenuItem<String>(
                  value: 'year',
                  child: Text('Year'),
                ),
                DropdownMenuItem<String>(
                  value: 'popularity',
                  child: Text('Popularity'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: widget.movies.length + 1,
              itemBuilder: (context, index) {
                
                
                if(index == widget.movies.length ) {
                  
                  // await widget.increaseCount();
                 // print('${widget.movies.length}');
                  //return Text('Hey');
                  return const Center(child: CircularProgressIndicator());
            
                }
                final movie = widget.movies[index];
                       
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMovieIndex = index;
                    });
                  },
                  child: Card(
                    elevation: selectedMovieIndex == index ? 5.0 : 2.0,
                    color: selectedMovieIndex == index ? const Color.fromARGB(255, 33, 145, 243) : Colors.white,
                    child: ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.poster}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Year: ${movie.year}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Rating: ${movie.rating}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}