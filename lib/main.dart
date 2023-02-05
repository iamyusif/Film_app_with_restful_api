import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Filmler.dart';
import 'FilmlerCavab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // black and white theme
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Filmler> parseKisilerCevap(String cevap) {
    return FilmlerCavab.fromJson(json.decode(cevap)).filmler;
  }

  Future<List<Filmler>> filmler() async {
    var url = Uri.parse("https://hasanzade.site/api/v2.php");
    var response = await http.get(url);
    var filmlerCavab = FilmlerCavab.fromJson(json.decode(response.body));
    return filmlerCavab.filmler;
  }

  Future<void> FilimleriGoster() async {
    var kisiler = await filmler();

    for (var kisi in kisiler) {
      print("*******************************************");
      print("Film Adı: ${kisi.film_ad}");
      print("Film Yılı: ${kisi.film_yil}");
      print("Film Resim: ${kisi.film_resim}");
      print("Film İçerik: ${kisi.film_icerik}");
      print("*******************************************");
    }
  }

  @override
  void initState() {
    super.initState();
    // FilimleriGoster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // image in the app bar center
     // image center
        title: Image.asset(
          "photos/filix.png",
          width: 200,
          height: 200,
        ),
        centerTitle: true,
      ),
      body:
          FutureBuilder<List<Filmler>>(
        future: filmler(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.only(top: 10,left: 2,right: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: Text(
                                snapshot.data![index].film_ad,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              centerTitle: true,
                            ),
                            body: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 10,
                                    shadowColor: Colors.orange,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![index].film_resim,
                                        width: 380,
                                        height: 270,
                                        // border radius

                                      ),
                                      // border radius

                                    ),

                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${snapshot.data![index].film_ad}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Year: ${snapshot.data![index].film_yil}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Content: ${snapshot.data![index].film_icerik}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    // size
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange,
                                      onPrimary: Colors.white,
                                      minimumSize: const Size(100, 50),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(2)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Back"),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      color: Colors.orange[50],
                      shadowColor: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(

                              snapshot.data![index].film_resim,
                              width: 200,
                              height: 150,
                            ),
                            // ara birak
                            Text(
                              " ${snapshot.data![index].film_ad}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Year: ${snapshot.data![index].film_yil}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,

                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
