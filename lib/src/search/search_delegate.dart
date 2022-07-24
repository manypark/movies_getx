import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:movies_getx/src/providers/movies_controller.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Buscar una pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon     : const Icon( Icons.clear ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close( context, null ), icon: const Icon( Icons.arrow_back ) );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  // ignore: non_constant_identifier_names
   Widget _EmptyContainer() {
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
      );
    }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty) {
      return _EmptyContainer();
    }

    final moviesCtrl = Get.find<MovieController>();
    moviesCtrl.getSuggestionByQuery(query);

    return StreamBuilder(
      stream  : moviesCtrl.suggestionStream,
      builder : ( _, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) return _EmptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount   : movies.length,
          itemBuilder : ( _, int i) {
            return _MovieItem(movies[i]);
          }
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          placeholder : const AssetImage('assets/no-image.jpg'),
          image       : NetworkImage(movie.fullPosterImg),
          width       : 50,
          fit         : BoxFit.contain
        ),
        title   : Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () {
          Navigator.pushNamed(context, 'details', arguments: movie);
        },
      ),
    );
  }
}