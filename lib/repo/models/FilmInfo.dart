import 'package:collection/collection.dart';

class FilmInfo {
  final int id;
  final String name;
  final String country;
  final String posterUrl;
  final int year;
  final String description;
  final List<String> genres;
  final int duration;

  FilmInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.posterUrl,
    required this.year,
    required this.description,
    required this.genres,
    required this.duration
  });



  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FilmInfo &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              country == other.country &&
              posterUrl == other.posterUrl &&
              year == other.year &&
              description == other.description &&
              const ListEquality().equals(genres, other.genres) &&
              duration == other.duration;
}