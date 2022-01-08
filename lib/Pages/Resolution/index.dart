import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Model/enum.dart';

class Resolution extends StatefulWidget {
  const Resolution({Key? key}) : super(key: key);

  @override
  _ResolutionState createState() => _ResolutionState();
}

// obs variables
Rx<ProblemeType> _problemeTypeController = ProblemeType.MAX.obs;

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
              Wrap(
                spacing: 30,
                runSpacing: 30,
                children: [const FormProblemeType()],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormProblemeType extends StatelessWidget {
  const FormProblemeType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Get.theme.backgroundColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Type d'optimisation",
                style: Get.textTheme.caption,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      child: InkWell(
                          autofocus: true,
                          onTap: () =>
                              _problemeTypeController.value = ProblemeType.MAX,
                          child: Text(
                            "Maximisation",
                            style: Get.theme.textTheme.bodyText2,
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: _problemeTypeController.value == ProblemeType.MAX
                            ? Get.theme.scaffoldBackgroundColor
                            : null,
                      )),
                  const SizedBox(width: 10),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      child: InkWell(
                          onTap: () =>
                              _problemeTypeController.value = ProblemeType.MIN,
                          child: Text(
                            "Minimisation",
                            style: Get.theme.textTheme.bodyText2,
                          )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: _problemeTypeController.value == ProblemeType.MIN
                            ? Get.theme.scaffoldBackgroundColor
                            : null,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
