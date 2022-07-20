import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, 
    this.title,
    required this.movies,
    required this.onNextPage,
    
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width : double.infinity,    
      height: 280.0,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if( widget.title != null )
          Padding(
            padding : const EdgeInsets.symmetric( horizontal: 20.0),
            child   : Text( widget.title! , style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold),),
          ),

          const SizedBox( height: 10.0,),

          Expanded(
            child: ListView.builder(
              controller      : scrollController,
              scrollDirection : Axis.horizontal,
              itemCount       : widget.movies.length,
              itemBuilder     : (_ ,int i) => _MoviePoster(widget.movies[i], '${widget.title}-$i-${widget.movies[i].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroID;

  const _MoviePoster(this.movie, this.heroID) : super();

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroID;

    return Container(
      width : 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child : Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),

            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                      
                child: FadeInImage(
                  placeholder : const AssetImage('assets/no-image.jpg'),
                  image       : NetworkImage(movie.fullPosterImg),
                  width       : 130.0,
                  height      : 190.0,
                  fit         : BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox( height: 5.0,),
          Text(
            movie.title,
            overflow  : TextOverflow.ellipsis,
            maxLines  : 2,
            textAlign : TextAlign.center,
          ),
        ],
      ),
    );
  }
}