import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test/screen/pokemon.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({super.key});

  @override
  State<Pokedex> createState() => _Pokedex();
}

class _Pokedex extends State<Pokedex> {
  // Esta es la función que obtiene el listado de pokemon
  Future<List<dynamic>> getPokemonList(int limit) async {
    // La URL de la Poke API que devuelve un listado de pokemon
    Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$limit');

    // Hacemos una solicitud HTTP GET a la URL
    var response = await http.get(url);

    // Verificamos que la respuesta fue exitosa
    if (response.statusCode == 200) {
      // Decodificamos la respuesta JSON
      var data = jsonDecode(response.body);

      // Obtenemos el listado de pokemon del JSON
      var pokemonList = data['results'];
      return pokemonList;
    } else {
      // Si hay un error, lanzamos una excepción
      throw Exception('Error al obtener la lista de pokemon 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: Center(
        child: FutureBuilder(
          future: getPokemonList(20),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Si tenemos datos, construimos la lista
              var pokemonList = snapshot.data;
              return ListView.builder(
                itemCount: pokemonList?.length ?? 0,
                itemBuilder: (context, index) {
                  var pokemon = pokemonList?[index] ?? {};
                  return ListTile(
                    leading: const Icon(Icons.catching_pokemon),
                    trailing: const Text(
                      "Paralela",
                      style: TextStyle(
                          color: Color.fromARGB(255, 19, 15, 5), fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pokemon(
                              name: pokemon["name"],
                              url: pokemon["url"],
                            ),
                          ));
                    },
                    title: Text(pokemon["name"]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              // Si hay un error, mostramos un mensaje de error
              return Text("Error al obtener la lista de pokemon 2");
            } else {
              // Si aún no tenemos datos, mostramos un spinner de carga
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
