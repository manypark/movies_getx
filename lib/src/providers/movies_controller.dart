
import 'package:get/get.dart';

import '../models/models.dart';
import 'package:http/http.dart' as http;
import '../models/populares_response.dart';

class MovieController extends GetxController {

  final RxList<Movie> onDisplyaMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies   = <Movie>[].obs;
  final String _apiKey    = '66153612008f5fb6e17d80cc5093b2a9';
  final String _baseUrl   = 'api.themoviedb.org';
  final String _language  = 'es-ES';
  int _popularPage  = 0;


  getOnDisplayMovies() async {
    final jsonDAta = await _getJSONData('3/movie/now_playing');
    final nowPlayginReposne = NowPlayingReponse.fromJson(jsonDAta);
    onDisplyaMovies.value = nowPlayginReposne.results;
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonDAta = await _getJSONData('3/movie/popular', _popularPage);

    final popularResponse = PopularReponse.fromJson(jsonDAta);

    popularMovies.value = [...popularMovies, ...popularResponse.results];
  }

  //  future para peticiones, centralizado
  Future<String> _getJSONData(String segment, [int page = 1] ) async {

    var url = Uri.https(_baseUrl, segment, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page',
    });

    final response = await http.get(url);

    return response.body;
  }

}