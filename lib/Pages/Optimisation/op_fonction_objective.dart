import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OpFonctionObjective extends StatelessWidget {
  const OpFonctionObjective({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Probleme p = context.watch<Probleme>();
    return CardForm(
      widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Fonction objective",
                style: Get.theme.textTheme.subtitle2,
              ),
            ),
          ],
        ),
        const Divider(),
        p.toFonctionObjectiveWidget()
      ]),
    );
  }
}

class OpFonctionObjectiveCust extends StatelessWidget {
  const OpFonctionObjectiveCust(
      {Key? key, required this.p, required this.title})
      : super(key: key);
  final Probleme p;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CardForm(
      widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Get.theme.textTheme.subtitle2,
              ),
            ),
          ],
        ),
        const Divider(),
        p.toFonctionObjectiveWidget()
      ]),
    );
  }
}

class PWOpFonctionObjective extends StatelessWidget {
  const PWOpFonctionObjective({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Probleme p = context.watch<Probleme>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(
            child: Text(
              "Fonction objective",
              style: Get.theme.textTheme.subtitle2,
            ),
          ),
        ],
      ),
      const Divider(),
      p.toFonctionObjectiveWidget()
    ]);
  }
}
