import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/src/provider.dart';

class OpFormeStandard extends StatelessWidget {
  const OpFormeStandard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Probleme p = context.watch<Probleme>().copyWith();
    return CardForm(
      widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Forme standard",
                style: Get.theme.textTheme.subtitle2,
              ),
            ),
          ],
        ),
        const Divider(),
        p.toFormCanoniqueWidget(p.toStandart())
      ]),
    );
  }
}
