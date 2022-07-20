import 'dart:convert';

class Movie {
    Movie({
                this.backdropPath,
                this.posterPath,
                this.releaseDate,
       required this.adult,
       required this.genreIds,
       required this.id,
       required this.originalLanguage,
       required this.originalTitle,
       required this.overview,
       required this.popularity,
       required this.title,
       required this.video,
       required this.voteAverage,
       required this.voteCount,
    });

    bool adult;
    bool video;
    double popularity;
    double voteAverage;
    int id;
    int voteCount;
    List<int> genreIds;
    String originalLanguage;
    String originalTitle;
    String overview;
    String title;
    String? backdropPath;
    String? posterPath;
    String? releaseDate;
    String? heroId;

    get fullPosterImg {
      if(posterPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';

      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    get fullbackdropPath {

      if(backdropPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';

      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult             : json["adult"],
        backdropPath      : json["backdrop_path"],
        genreIds          : List<int>.from(json["genre_ids"].map((x) => x)),
        id                : json["id"],
        originalLanguage  : json["original_language"],
        originalTitle     : json["original_title"],
        overview          : json["overview"],
        popularity        : json["popularity"].toDouble(),
        posterPath        : json["poster_path"],
        releaseDate       : json["release_date"],
        title             : json["title"],
        video             : json["video"],
        voteAverage       : json["vote_average"].toDouble(),
        voteCount         : json["vote_count"]
    );
}