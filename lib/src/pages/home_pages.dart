import 'package:flutter/material.dart';
import 'package:movies_getx/src/widgets/card_swiper.dart';

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
            onPressed: (){}, 
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
          ]
        ),
      )
    );
  }
}