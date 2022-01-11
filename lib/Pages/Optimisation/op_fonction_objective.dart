import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/provider.dart';

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
