class Filmler {

  String film_id;
  String film_ad;
  String film_yil;
  String film_resim;
  String film_icerik;

  Filmler(this.film_id, this.film_ad, this.film_yil, this.film_resim, this.film_icerik);


  factory Filmler.fromJson(Map<String, dynamic> json) {
    return Filmler(
      json['film_id'] as String,
      json['film_ad'] as String,
      json['film_yil'] as String,
      json['film_resim'] as String,
      json['film_icerik'] as String,
    );
  }


}

// @iamyusifh github.com/iamyusifh
