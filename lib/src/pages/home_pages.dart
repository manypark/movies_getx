import 'package:flutter/material.dart';
import 'package:movies_getx/src/widgets/card_swiper.dart';

import '../search/search_delegate.dart';
import '../widgets/movie_slider.dart';

class HomePages extends StatelessWidget {

  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cartelera', style: TextStyle( color: Colors.black ),),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon( Icons.search , color: Colors.black ),
            onPressed: () => showSearch(
              context : context, 
              delegate: MovieSearchDelegate()
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            //Cartelera
            CardSwiper(),

            //Espacio entre cartelera y populares
            const SizedBox(height: 30.0,),

            //Infinite scroll de peliculas
            const MovieSlider(),            
          ]
        ),
      )
    );
  }
}