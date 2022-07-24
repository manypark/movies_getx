
import 'dart:async';
import 'package:get/get.dart';
import '../helpers/debouncer.dart';
import '../models/credit_response.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;
import '../models/populares_response.dart';
import '../models/search_movies_response.dart';

class MovieController extends GetxController {

  final RxList<Movie> onDisplyaMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies   = <Movie>[].obs;
  final String _apiKey    = '66153612008f5fb6e17d80cc5093b2a9';
  final String _baseUrl   = 'api.themoviedb.org';
  final String _language  = 'es-ES';
  int _popularPage  = 0;
  Map<int, List<Cast>> moviesCast = {};
  final debouncer = Debouncer( duration: const Duration(milliseconds: 500) );
  final StreamController<List<Movie>> _suggestionStreanController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreanController.stream;


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

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonDAta = await _getJSONData('3/movie/$movieId/credits');
    final creditResponse = CreditsResponse.fromJson(jsonDAta);

    moviesCast[movieId] = creditResponse.cast;

    return creditResponse.cast;
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

   Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '1',
      'query'   : query
    });

    final response = await http.get(url);

    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovie(query);
      _suggestionStreanController.add( result );
    };

    final timer = Timer.periodic( const Duration( milliseconds: 300 ), (_) {
      debouncer.value = query;
    });

    Future.delayed( const Duration( milliseconds: 301 )).then((_) => timer.cancel());
  }

}