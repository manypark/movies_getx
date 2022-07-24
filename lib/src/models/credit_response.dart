import 'dart:convert';

class CreditsResponse {

    CreditsResponse({
       required this.id,
       required this.cast,
       required this.crew,
    });

    int id;
    List<Cast> cast;
    List<Cast> crew;

    factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));

    factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );
}

class Cast {

    Cast({
      required this.adult,
      required this.creditId,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      this.castId,
      this.character,
      this.department,
      this.job,
      this.order,
      this.profilePath,
    });

    bool adult;
    double popularity;
    int gender;
    int id;
    int? castId;
    int? order;
    String creditId;
    String knownForDepartment;
    String name;
    String originalName;
    String? character;
    String? department;
    String? job;
    String? profilePath;

    get fullProfilePath {
      if(profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult               : json["adult"],
        gender              : json["gender"],
        id                  : json["id"],
        knownForDepartment  : json["known_for_department"],
        name                : json["name"],
        originalName        : json["original_name"],
        popularity          : json["popularity"].toDouble(),
        profilePath         : json["profile_path"] == null ? null : json["profile_path"],
        castId              : json["cast_id"] == null ? null : json["cast_id"],
        character           : json["character"] == null ? null : json["character"],
        creditId            : json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
    );

}
