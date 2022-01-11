import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/algorithme.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:provider/provider.dart';

class OpTableau extends StatefulWidget {
  final Probleme probleme;

  const OpTableau({Key? key, required this.probleme}) : super(key: key);

  @override
  State<OpTableau> createState() => _OpTableauState();
}

class _OpTableauState extends State<OpTableau> {
  getTabs(Probleme p) {
    List<Tableau> tabs = Algorithme().start(probleme: p).toList();
    //  print(tabs);
  }

  @override
  void initState() {
    getTabs(widget.probleme);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Algorithme()
        .start(probleme: widget.probleme)
        .map((e) => e.cj_zj)
        .toList());
    List<Tableau> tabs = [];
    //.toList();
    return ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          //print(tabs[index].vdb);
          return OpTableauItem(t: tabs[index]);
        });
  }
}

class OpTableauItem extends StatelessWidget {
  final Tableau t;
  const OpTableauItem({Key? key, required this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: CardForm(
        widget: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Tableau " +
                      (t.numero == 1 ? "initial" : t.numero.toString()),
                  style: Get.theme.textTheme.subtitle2,
                ),
              ),
            ],
          ),
          const Divider(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            child: DataTable(
              border: TableBorder.all(),
              headingRowHeight: 36,
              columnSpacing: 50,
              columns: [
                const DataColumn(
                    label: DatatableTitle(s: "Coef"),
                    numeric: true,
                    tooltip: "Coefficients"),
                const DataColumn(
                    label: DatatableTitle(s: "VDB"),
                    numeric: false,
                    tooltip: "Variable de base"),
                ...t.variables.first
                    .map(
                      (e) => DataColumn(
                          label: DatatableTitleVariable(s: e.name),
                          numeric: true),
                    )
                    .toList(),
                const DataColumn(
                    label: DatatableTitle(s: "ST"),
                    numeric: true,
                    tooltip: "Second terme"),
                // DataColumn(label: DatatableTitle(s: "Rapport"), numeric: true),
              ],
              rows: [
                ...List.generate(
                    t.variables.length,
                    (i) => DataRow(cells: [
                          DataCell(Text(t.vdb[i].removeDecimalZeroFormat())),
                          DataCell(t.vdb[i].getNameWidget()),
                          ...t.variables[i].map((e) => DataCell(
                              Text(Fonction.removeDecimalZeroFormat(e.value)))),
                          DataCell(
                              Text(Fonction.removeDecimalZeroFormat(t.st[i]))),
                        ])).toList(),
                DataRow(cells: [
                  const DataCell(SizedBox()),
                  DataCell(Text(
                    "Cj",
                    style: Get.textTheme.subtitle2,
                  )),
                  ...t.cj
                      .map((e) =>
                          DataCell(Text(Fonction.removeDecimalZeroFormat(e))))
                      .toList(),
                  const DataCell(SizedBox()),
                ]),
                DataRow(cells: [
                  const DataCell(SizedBox()),
                  DataCell(Text(
                    "Zj",
                    style: Get.textTheme.subtitle2,
                  )),
                  ...t.zj
                      .map((e) =>
                          DataCell(Text(Fonction.removeDecimalZeroFormat(e))))
                      .toList(),
                  const DataCell(SizedBox()),
                ]),
                DataRow(cells: [
                  const DataCell(SizedBox()),
                  DataCell(Text(
                    "Cj-Zj",
                    style: Get.textTheme.subtitle2,
                  )),
                  ...t.cj_zj
                      .map((e) =>
                          DataCell(Text(Fonction.removeDecimalZeroFormat(e))))
                      .toList(),
                  const DataCell(SizedBox()),
                ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class DatatableTitle extends StatelessWidget {
  final String s;
  const DatatableTitle({Key? key, required this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(s,
          style: Get.theme.textTheme.headline3!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w900)),
    );
  }
}

class DatatableTitleVariable extends StatelessWidget {
  final String s;
  const DatatableTitleVariable({Key? key, required this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
          text: TextSpan(
              text: s[0],
              style: Get.theme.textTheme.headline1!.copyWith(fontSize: null),
              children: [
            //!Waarning might throw exception
            TextSpan(
              text: s[1],
              style: Get.theme.textTheme.headline1!.copyWith(
                  fontSize: 15, color: Get.theme.primaryColor.withOpacity(0.6)),
            ),
          ])),
    );
  }
}
