import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_list_app/Screens/addmoviescreen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movies_list_app/providers/moviesprovider.dart';


class HomeScreen extends StatelessWidget {
 const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: ListTile(
                        leading: CircleAvatar(radius: 26,backgroundImage: FileImage(movie.poster),),
                        title: Text(movie.name),
                        subtitle: Text(movie.director),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            movieProvider.deleteMovie(index);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddMovieScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}