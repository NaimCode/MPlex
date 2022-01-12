import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Widgets/mini.dart';

class SauvegardeItem extends StatelessWidget {
  final Probleme p;

  const SauvegardeItem({Key? key, required this.p}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Fonction.toOptimisation(probleme: p),
        child: CardForm(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fonction objective",
                style: Get.theme.textTheme.caption,
              ),
              const SizedBox(height: 3),
              p.getApercuFonctionObjective(),
              const SizedBox(height: 6),
              Text(
                "Forme canonique",
                style: Get.theme.textTheme.caption,
              ),
              const SizedBox(height: 3),
              p.getApercuFormeCanonique()
            ],
          ),
        ),
      ),
    );
  }
}
