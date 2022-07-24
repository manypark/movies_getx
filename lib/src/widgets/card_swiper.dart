import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_getx/src/providers/movies_controller.dart';

class CardSwiper extends StatelessWidget {

  final moviesCtrl = Get.put( MovieController() );

  CardSwiper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final size = MediaQuery.of(context).size;

    if( moviesCtrl.onDisplyaMovies.isEmpty ) {
      moviesCtrl.getOnDisplayMovies();
    }

    return Obx( () => 
      CarouselSlider(
        options : CarouselOptions(
          height            : 450.0,
          autoPlay          : true,
          viewportFraction  : 0.7,
          enlargeCenterPage : true,
        ),
        items   : moviesCtrl.onDisplyaMovies.map( (i) {

          final movie = i;

          movie.heroId = 'swiper-${movie.id}';

          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () => Get.toNamed( 'details', arguments: movie ),
                child: Container(
                  width : MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child : Hero(
                    tag: movie.heroId!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child       : FadeInImage(
                        placeholder : const AssetImage('assets/no-image.jpg'),
                        image       : NetworkImage( i.fullPosterImg ),
                        fit          : BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

}