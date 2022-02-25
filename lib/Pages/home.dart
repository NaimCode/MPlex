import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/algorithme.dart';
import 'package:mplex/Model/constante.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final Algorithme algorithme = Algorithme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage("assets/bg_3.jpg"))),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    color: Colors.blue.withOpacity(0),
                  ),
                ),
              )),
          Center(
            child: ElevatedButton(
                onPressed: () {},
                child: const Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                  size: 30,
                )),
          )
        ],
      ),
    );
  }
}
