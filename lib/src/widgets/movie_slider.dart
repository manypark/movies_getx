import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_getx/src/providers/movies_controller.dart';
import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  const MovieSlider({
    Key? key, 
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();
  final moviesCtrl = Get.find<MovieController>();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ) {
        moviesCtrl.getPopularMovies();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    moviesCtrl.getPopularMovies();

    return SizedBox(
      width : double.infinity,    
      height: 280.0,
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Padding(
            padding : EdgeInsets.symmetric( horizontal: 20.0),
            child   : Text( 'Populares' , style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold),),
          ),

          const SizedBox( height: 10.0,),

          Obx( () => Expanded(
              child: ListView.builder(
                controller      : scrollController,
                scrollDirection : Axis.horizontal,
                // itemCount       : widget.movies.length,
                itemCount       : moviesCtrl.popularMovies.length,
                itemBuilder     : (_ ,int i) => _MoviePoster( moviesCtrl.popularMovies[i], 'Populares-$i-${moviesCtrl.popularMovies[i].id}'),
              ),
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

            // onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
            onTap: () => Get.toNamed('details', arguments: movie ),
            child: Hero(
              tag   : movie.heroId!,
              child : ClipRRect(
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