import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/form_probleme_name.dart';

import 'controller.dart';
import 'form_probleme_type.dart';
import 'form_variables.dart';

class Resolution extends StatefulWidget {
  const Resolution({Key? key}) : super(key: key);

  @override
  _ResolutionState createState() => _ResolutionState();
}

// obs variables

///

///
class _ResolutionState extends State<Resolution> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Get.theme.backgroundColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: ElevatedButton.icon(
                          label: Text(
                            "Aperçu",
                            style: Get.theme.textTheme.bodyText2,
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility_outlined,
                            color: Get.theme.iconTheme.color,
                          )))
                ],
              ),
            )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Get.theme.backgroundColor),
          height: 60,
          child: Row(
            children: [TextButton(onPressed: () {}, child: Text("Suivant"))],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 13.0, left: 13, bottom: 13, right: 13),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Optimisation linéaire",
                style: Get.theme.textTheme.headline5,
              ),
              const SizedBox(height: 10),
              Text(
                "Completez le formulaire suivant afin de lancer l'optimisation",
                style: Get.theme.textTheme.caption,
              ),
              const SizedBox(height: 30),
              const FormProblemeType(),
              const SizedBox(height: 30),
              const FormVariables(),
            ],
          ),
        ),
      ),
    );
  }
}
