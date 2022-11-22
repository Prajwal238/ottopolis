// To parse this JSON data, do
//
//     final showModel = showModelFromJson(jsonString);

import 'dart:convert';

List<ShowModel> showModelFromJson(String str) =>
    List<ShowModel>.from(json.decode(str).map((x) => ShowModel.fromJson(x)));

String showModelToJson(List<ShowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowModel {
  ShowModel({
    this.score,
    this.show,
  });

  double? score;
  Show? show;

  ShowModel copyWith({
    double? score,
    Show? show,
  }) =>
      ShowModel(
        score: score ?? this.score,
        show: show ?? this.show,
      );

  factory ShowModel.fromJson(Map<String, dynamic> json) => ShowModel(
        score: json["score"]?.toDouble(),
        show: json["show"] == null ? null : Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score,
        "show": show?.toJson(),
      };
}

class Show {
  Show({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    this.weight,
    this.network,
    this.webChannel,
    this.dvdCountry,
    this.externals,
    this.img,
    this.summary,
    this.updated,
    this.links,
  });

  int? id;
  String? url;
  String? name;
  String? type;
  String? language;
  List<String>? genres;
  String? status;
  int? runtime;
  int? averageRuntime;
  DateTime? premiered;
  DateTime? ended;
  String? officialSite;
  Schedule? schedule;
  Rating? rating;
  int? weight;
  Network? network;
  Network? webChannel;
  dynamic dvdCountry;
  Externals? externals;
  Img? img;
  String? summary;
  int? updated;
  Links? links;

  Show copyWith(
          {int? id,
          String? url,
          String? name,
          String? type,
          String? language,
          List<String>? genres,
          String? status,
          int? runtime,
          int? averageRuntime,
          DateTime? premiered,
          DateTime? ended,
          String? officialSite,
          Schedule? schedule,
          Rating? rating,
          int? weight,
          Network? network,
          Network? webChannel,
          dynamic dvdCountry,
          Externals? externals,
          Img? img,
          String? summary,
          int? updated,
          Links? links}) =>
      Show(
        id: id ?? this.id,
        url: url,
        name: name,
        type: type,
        language: language,
        genres: genres,
        status: status,
        runtime: runtime,
        averageRuntime: averageRuntime,
        premiered: premiered,
        ended: ended,
        officialSite: officialSite,
        schedule: schedule,
        rating: rating,
        weight: weight,
        network: network,
        webChannel: webChannel,
        dvdCountry: dvdCountry,
        externals: externals,
        img: img,
        summary: summary,
        updated: updated,
        links: links,
      );

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        language: json["language"],
        genres: json["genres"] == null ? null : List<String>.from(json["genres"].map((x) => x)),
        status: json["status"],
        runtime: json["runtime"],
        averageRuntime: json["averageRuntime"],
        premiered: json["premiered"] == null ? null : DateTime.parse(json["premiered"]),
        ended: json["ended"] == null ? null : DateTime.parse(json["ended"]),
        officialSite: json["officialSite"],
        schedule: json["schedule"] == null ? null : Schedule.fromJson(json["schedule"]),
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
        weight: json["weight"],
        network: json["network"] == null ? null : Network.fromJson(json["network"]),
        webChannel: json["webChannel"] == null ? null : Network.fromJson(json["webChannel"]),
        dvdCountry: json["dvdCountry"],
        externals: json["externals"] == null ? null : Externals.fromJson(json["externals"]),
        img: json["image"] == null ? null : Img.fromJson(json["image"]),
        summary: json["summary"],
        updated: json["updated"],
        links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "type": type,
        "language": language,
        "genres": genres == null ? null : List<dynamic>.from(genres!.map((x) => x)),
        "status": status,
        "runtime": runtime,
        "averageRuntime": averageRuntime,
        "premiered": premiered == null
            ? null
            : "${premiered?.year.toString().padLeft(4, '0')}-${premiered?.month.toString().padLeft(2, '0')}-${premiered?.day.toString().padLeft(2, '0')}",
        "ended": ended == null
            ? null
            : "${ended?.year.toString().padLeft(4, '0')}-${ended?.month.toString().padLeft(2, '0')}-${ended?.day.toString().padLeft(2, '0')}",
        "officialSite": officialSite,
        "schedule": schedule?.toJson(),
        "rating": rating?.toJson(),
        "weight": weight,
        "network": network?.toJson(),
        "webChannel": webChannel?.toJson(),
        "dvdCountry": dvdCountry,
        "externals": externals?.toJson(),
        "img": img?.toJson(),
        "summary": summary,
        "updated": updated,
        "_links": links?.toJson(),
      };
}

class Externals {
  Externals({
    this.tvrage,
    this.thetvdb,
    this.imdb,
  });

  dynamic tvrage;
  int? thetvdb;
  String? imdb;

  Externals copyWith({
    dynamic tvrage,
    int? thetvdb,
    String? imdb,
  }) =>
      Externals(
        tvrage: tvrage ?? this.tvrage,
        thetvdb: thetvdb ?? this.thetvdb,
        imdb: imdb ?? this.imdb,
      );

  factory Externals.fromJson(Map<String, dynamic> json) => Externals(
        tvrage: json["tvrage"],
        thetvdb: json["thetvdb"],
        imdb: json["imdb"],
      );

  Map<String, dynamic> toJson() => {
        "tvrage": tvrage,
        "thetvdb": thetvdb,
        "imdb": imdb,
      };
}

class Img {
  Img({
    this.medium,
    this.original,
  });

  String? medium;
  String? original;

  Img copyWith({
    String? medium,
    String? original,
  }) =>
      Img(
        medium: medium ?? this.medium,
        original: original ?? this.original,
      );

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        medium: json["medium"],
        original: json["original"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
        "original": original,
      };
}

class Links {
  Links({
    this.self,
    this.previousepisode,
    this.nextepisode,
  });

  Nextepisode? self;
  Nextepisode? previousepisode;
  Nextepisode? nextepisode;

  Links copyWith({
    Nextepisode? self,
    Nextepisode? previousepisode,
    Nextepisode? nextepisode,
  }) =>
      Links(
        self: self ?? this.self,
        previousepisode: previousepisode ?? this.previousepisode,
        nextepisode: nextepisode ?? this.nextepisode,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"] == null ? null : Nextepisode.fromJson(json["self"]),
        previousepisode: json["previousepisode"] == null ? null : Nextepisode.fromJson(json["previousepisode"]),
        nextepisode: json["nextepisode"] == null ? null : Nextepisode.fromJson(json["nextepisode"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
        "previousepisode": previousepisode?.toJson(),
        "nextepisode": nextepisode?.toJson(),
      };
}

class Nextepisode {
  Nextepisode({
    this.href,
  });

  String? href;

  Nextepisode copyWith({
    String? href,
  }) =>
      Nextepisode(
        href: href ?? this.href,
      );

  factory Nextepisode.fromJson(Map<String, dynamic> json) => Nextepisode(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Network {
  Network({
    this.id,
    this.name,
    this.country,
    this.officialSite,
  });

  int? id;
  String? name;
  Country? country;
  String? officialSite;

  Network copyWith({
    int? id,
    String? name,
    Country? country,
    String? officialSite,
  }) =>
      Network(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
        officialSite: officialSite ?? this.officialSite,
      );

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        name: json["name"],
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        officialSite: json["officialSite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country?.toJson(),
        "officialSite": officialSite,
      };
}

class Country {
  Country({
    this.name,
    this.code,
    this.timezone,
  });

  String? name;
  String? code;
  String? timezone;

  Country copyWith({
    String? name,
    String? code,
    String? timezone,
  }) =>
      Country(
        name: name ?? this.name,
        code: code ?? this.code,
        timezone: timezone ?? this.timezone,
      );

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        code: json["code"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "timezone": timezone,
      };
}

class Rating {
  Rating({
    this.average,
  });

  double? average;

  Rating copyWith({
    double? average,
  }) =>
      Rating(
        average: average ?? this.average,
      );

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        
        average: json["average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
      };
}

class Schedule {
  Schedule({
    this.time,
    this.days,
  });

  String? time;
  List<dynamic>? days;

  Schedule copyWith({
    String? time,
    List<dynamic>? days,
  }) =>
      Schedule(
        time: time ?? this.time,
        days: days ?? this.days,
      );

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        time: json["time"],
        days: json["days"] == null ? null : List<dynamic>.from(json["days"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "days": days == null ? null : List<dynamic>.from(days!.map((x) => x)),
      };
}
