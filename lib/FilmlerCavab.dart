import 'Filmler.dart';

class FilmlerCavab {

  List<Filmler> filmler;

  FilmlerCavab(this.filmler);

  factory FilmlerCavab.fromJson(Map<String, dynamic> json) {
    var list = json['filmler'] as List;
    List<Filmler> filmlerList = list.map((i) => Filmler.fromJson(i)).toList();

    return FilmlerCavab(filmlerList);
  }

}