import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Optimisation/op_form_canonique.dart';
import 'package:mplex/Pages/Optimisation/op_form_standard.dart';
import 'package:mplex/Pages/Optimisation/op_tableau.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/provider.dart';

import 'op_fonction_objective.dart';

class Optimisation extends StatefulWidget {
  final Probleme probleme;
  const Optimisation({Key? key, required this.probleme}) : super(key: key);

  @override
  _OptimisationState createState() => _OptimisationState();
}

class _OptimisationState extends State<Optimisation> {
  ScrollController scrollController = ScrollController();
  late Probleme p;

  @override
  void initState() {
    p = widget.probleme.type == ProblemeType.MAX
        ? widget.probleme
        : widget.probleme.toDual();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Provider<Probleme>(
        create: (context) => p,
        child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) =>
                [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    automaticallyImplyLeading: false,
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
                            child: ElevatedButton(
                                child: Text(
                                  "Retour",
                                  style: Get.theme.textTheme.bodyText2,
                                ),
                                onPressed: () => Get.back()),
                          ),
                          ValueListenableBuilder(
                              valueListenable:
                                  Hive.box("sauvegarde").listenable(),
                              builder: (context, Box b, _) {
                                List<Probleme> problemes =
                                    b.values.toList().cast();
                                bool exist = problemes.any(
                                    (element) => element == widget.probleme);
                                return Tooltip(
                                  message: exist
                                      ? "Retirer le problème"
                                      : "Sauvegarder le problème",
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // color: exist
                                          //     ? Colors.red
                                          //     : Get.theme.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: exist
                                                  ? Colors.red[300]
                                                  : null),
                                          child: Icon(
                                            exist
                                                ? Icons.bookmark_remove
                                                : Icons.bookmark_add,
                                            color: exist
                                                ? null
                                                : Get.theme.primaryColor,
                                          ),
                                          onPressed: () {
                                            if (exist) {
                                              b.deleteAt(b.values
                                                  .toList()
                                                  .indexOf(widget.probleme));
                                              // b.clear();
                                              // b.addAll(problemes.where(
                                              //     (element) =>
                                              //         element !=
                                              //         widget.probleme));
                                            } else {
                                              b.add(widget.probleme);
                                            }
                                          }),
                                    ),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  )
                ],
            body: Padding(
              padding: const EdgeInsets.only(top: 13.0, left: 13, right: 13),
              child: CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  widget.probleme.type == ProblemeType.MAX
                      ? SliverList(
                          delegate: SliverChildListDelegate([
                          const OpFonctionObjective(),
                          const SizedBox(height: 30),
                          const OpFormeCanonique(),
                          const SizedBox(height: 30),
                          const OpFormeStandard(),
                          const SizedBox(height: 30),
                          OpTableau(
                              probleme: Probleme(
                            forme: p.forme.copyWith(),
                            type: p.type,
                            name: p.name,
                            variables: p.variables.map((e) => e).toList(),
                          ))
                        ]))
                      : SliverList(
                          delegate: SliverChildListDelegate([
                          OpFonctionObjectiveCust(
                              p: widget.probleme,
                              title: "Primal: fonction objective"),
                          const SizedBox(height: 30),
                          OpFormeCanoniqueCust(
                              p: widget.probleme,
                              title: "Primal: forme canonique"),
                          const SizedBox(height: 30),
                          OpFonctionObjectiveCust(
                              p: p, title: "Dual: fonction objective"),
                          const SizedBox(height: 30),
                          OpFormeCanoniqueCust(
                              p: p, title: "Dual: forme canonique"),
                          const SizedBox(height: 30),
                          const OpFormeStandard(),
                          const SizedBox(height: 30),
                          OpTableau(
                              probleme: Probleme(
                            forme: p.forme.copyWith(),
                            type: p.type,
                            name: p.name,
                            variables: p.variables.map((e) => e).toList(),
                          ))
                        ]))
                ],
              ),
            )));
  }
}
