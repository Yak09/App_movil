import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pokemon extends StatefulWidget {
  final String name;
  final String url;

  const Pokemon({super.key, required this.name, required this.url});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  Future<dynamic> getPokemon(String url) async {
    // La URL de la Poke API que devuelve un listado de pokemon
    Uri poke = Uri.parse(url);

    // Hacemos una solicitud HTTP GET a la URL
    var response = await http.get(poke);

    // Verificamos que la respuesta fue exitosa
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      var data = jsonDecode(response.body);

      // Obtenemos el listado de pokemon del JSON
      return data;
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception('Error al obtener pokemon ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: FutureBuilder(
            future: getPokemon(widget.url),
            builder: (context, snapshot) {
              var pokemon = snapshot.data;
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Experiencia base:"),
                        Text(pokemon["base_experience"].toString()),
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}

/* 
ID
Nombre
Altura
Peso
Él o los tipos
Formas
Habilidades
Ubicación
Sprite o imagen
*/