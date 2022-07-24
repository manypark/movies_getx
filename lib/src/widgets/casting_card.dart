import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:movies_getx/src/providers/movies_controller.dart';

import '../models/credit_response.dart';

class CastingCard extends StatelessWidget {

  final int idMovie;

  const CastingCard({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {

    final movieCtrl = Get.find<MovieController>();

    return FutureBuilder(
      future  : movieCtrl.getMovieCast(idMovie),
      builder : ( _, AsyncSnapshot<List<Cast>> snapshot) {
        
        if( !snapshot.hasData ) {
          return Container(
            height      : 100.0,
            constraints : const BoxConstraints( maxWidth: 150 ),
            child       : const CupertinoActivityIndicator(),
          );
        }

        final cast = snapshot.data;

        return Container(
          width : double.infinity,
          height: 180.0,
          margin: const EdgeInsets.only( bottom: 30.0 ),
          child: ListView.builder(
            itemCount       : cast?.length,
            scrollDirection : Axis.horizontal,
            itemBuilder     : ( _, int i) => _CastCard( cast![i] ),
          ),
        );
      },

    );
  }

}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin : const EdgeInsets.symmetric( horizontal: 10.0 ),
      width  : 110,
      height : 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular( 20.0 ),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image      : NetworkImage( actor.fullProfilePath ),
              height     : 140,
              width      : 100,
              fit         : BoxFit.cover,
            ),
          ),

          const SizedBox( height: 5.0,),

          Text(
            actor.name,
            maxLines  : 2,
            overflow   : TextOverflow.ellipsis,
            textAlign : TextAlign.center,
          )
        ],
      ),
    );
  }
}