import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Resolution/form_probleme_name.dart';
import 'package:provider/provider.dart';

import 'button_apercu.dart';
import 'button_suivant.dart';
import 'controller.dart';
import 'form_contraintes.dart';
import 'form_probleme_type.dart';
import 'form_variables.dart';

class Resolution extends StatefulWidget {
  final ProblemeType type;
  const Resolution({Key? key, required this.type}) : super(key: key);

  @override
  _ResolutionState createState() => _ResolutionState();
}

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
    return Provider<FormController>(
      create: (_) => FormController(widget.type),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [ButtonApercu(), ButtonSuivant()],
                ),
              )),
          body: Scrollbar(
              controller: scrollController,
              child: ListView(
                padding: const EdgeInsets.only(top: 13.0, left: 13, right: 13),
                controller: scrollController,
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    "Optimisation linéaire",
                    style: Get.theme.textTheme.headline5!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Completez le formulaire suivant afin de lancer la ${widget.type == ProblemeType.MAX ? "maximisation" : "minimisation"}",
                    style: Get.theme.textTheme.caption!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const FormVariables(),
                  const SizedBox(height: 30),
                  const FormContraintes(),
                  const SizedBox(height: 30),
                ],
              )),
        ),
      ),
    );
  }
}
