import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_getx/src/models/movie.dart';

import '../widgets/casting_card.dart';

class DetailPages extends StatelessWidget {

  const DetailPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movieArgs = Get.arguments as Movie;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie: movieArgs ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( movie: movieArgs ),
              _OverView( movie: movieArgs ),
              CastingCard( idMovie: movieArgs.id ),
            ])
          ),
        ],
      ),
    );
  }

}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    Key? key, 
    required this.movie
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor : Colors.grey,
      expandedHeight  : 200.0,
      pinned          : true,
      elevation       : 0.0,
      floating         : false,
      flexibleSpace    : FlexibleSpaceBar(

        centerTitle : true,
        titlePadding: const EdgeInsets.all(0),
        title       : Container(
          width     : double.infinity,
          alignment : Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          child: Text( movie.title , style: const TextStyle(fontSize: 16.0), textAlign: TextAlign.justify ,),
        ),
        background: FadeInImage(
          placeholder : const AssetImage('assets/loading.gif'),
          image       : NetworkImage( movie.fullbackdropPath ),
          fit          : BoxFit.cover,
        ),

      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    super.key, 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin  : const EdgeInsets.only( top: 20.0 ),
      padding : const EdgeInsets.symmetric( horizontal: 20.0 ),
      child   : Row(
        children: [
          Hero(
            tag   : movie.heroId!,
            child : ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: FadeInImage(
                placeholder : const AssetImage('assets/no-image.jpg'),
                image       : NetworkImage(movie.fullPosterImg),
                height      : 150.0,
              ),
            )
          ),

          const SizedBox( height: 20.0 ,),

          Container(
            padding : const EdgeInsets.symmetric( horizontal: 15.0 ),
            child: ConstrainedBox(
              constraints: BoxConstraints( maxWidth: size.width - 190 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style   : textTheme.headline5,
                    overflow : TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    movie.originalTitle,
                    style   : textTheme.subtitle1,
                    overflow : TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      const Icon( Icons.star_border ),
                      const SizedBox( width: 5.0,),
                      Text( movie.voteAverage.toString(), style: textTheme.caption,)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

class _OverView extends StatelessWidget {

  final Movie movie;

  const _OverView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.all(20.0),
      child   : Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style    : Theme.of(context).textTheme.subtitle1 ,
      ),
    );
  }
}