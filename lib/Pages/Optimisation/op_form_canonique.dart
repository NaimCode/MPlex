import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/src/provider.dart';

class OpFormeCanonique extends StatelessWidget {
  const OpFormeCanonique({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Probleme p = context.watch<Probleme>().copyWith();
    return CardForm(
      widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Forme canonique",
                style: Get.theme.textTheme.subtitle2,
              ),
            ),
          ],
        ),
        const Divider(),
        p.toFormCanoniqueWidget(null)
      ]),
    );
  }
}

class OpFormeCanoniqueCust extends StatelessWidget {
  const OpFormeCanoniqueCust({Key? key, required this.p, required this.title})
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
        p.toFormCanoniqueWidget(null)
      ]),
    );
  }
}
