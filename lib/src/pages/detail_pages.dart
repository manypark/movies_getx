import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_getx/src/models/movie.dart';

class DetailPages extends StatelessWidget {

  const DetailPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Movie movieArgs = Get.arguments as Movie;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie: movieArgs ),
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