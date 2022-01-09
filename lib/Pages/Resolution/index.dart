import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/form_probleme_name.dart';

import 'controller.dart';
import 'form_contraintes.dart';
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
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                          ))),
                  Container(
                      decoration: BoxDecoration(
                          color: Get.theme.backgroundColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: ElevatedButton(
                        child: Text(
                          "Lancer",
                          style: Get.theme.textTheme.bodyText2,
                        ),
                        onPressed: () {},
                        // icon: Icon(
                        //   Icons.lau,
                        //   color: Get.theme.iconTheme.color,
                        // ),
                      ))
                ],
              ),
            )),
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //       color: Get.theme.backgroundColor,
        //       borderRadius: const BorderRadius.only(
        //           topLeft: Radius.circular(10), topRight: Radius.circular(10))),

        //   //  margin: const EdgeInsets.only(bottom: 10),
        //   height: 60,
        //   child: Row(
        //     children: [
        //       const Spacer(),
        //       TextButton(
        //           onPressed: () {},
        //           child: Text(
        //             "Lancer",
        //             style: Get.theme.textTheme.caption,
        //           ))
        //     ],
        //   ),
        // ),
        body: Scrollbar(
          controller: scrollController,
          child: ListView(
            padding: const EdgeInsets.only(top: 13.0, left: 13, right: 13),
            controller: scrollController,
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
              const SizedBox(height: 30),
              const FormContraintes(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
