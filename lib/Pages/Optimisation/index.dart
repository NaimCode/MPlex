import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';
import 'package:mplex/Pages/Optimisation/op_form_canonique.dart';
import 'package:mplex/Pages/Optimisation/op_form_standard.dart';
import 'package:mplex/Pages/Optimisation/op_tableau.dart';
import 'package:mplex/Widgets/mini.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
    p = widget.probleme;
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
                          ...[
                            ElevatedButton(
                                onPressed: () async {
                                  Directory? dic =
                                      await getApplicationDocumentsDirectory();

                                  String? path = await FilesystemPicker.open(
                                    title: 'Choisir un dossier',
                                    context: context,
                                    rootName: "Mes Documents",
                                    rootDirectory: dic,
                                    fsType: FilesystemType.folder,
                                    pickText: 'Exporter',
                                    fileTileSelectMode:
                                        FileTileSelectMode.wholeTile,
                                    folderIconColor: Get.theme.primaryColor,
                                  );
///////////////////////////////////////////////////////////////////////////
//////////////////////////////P////////////////////////////////////
//////////////////////////////D//////////////////////////////////////////
//////////////////////////////F//////////////////
//////////////////////////////////////////////////

                                  final pdf = pw.Document();
                                  final font = await rootBundle.load(
                                      "fonts/Pacifico/Pacifico-Regular.ttf");

                                  final tff = pw.Font.ttf(font);
                                  pdf.addPage(pw.Page(
                                      pageFormat: PdfPageFormat.a4,
                                      build: (pw.Context context) {
                                        return pw.Padding(
                                            padding: const pw.EdgeInsets.only(
                                                left: 13, right: 13),
                                            child: pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.Text("Fonction objective",
                                                      style: const pw.TextStyle(
                                                        fontSize: 15,
                                                      )),
                                                  pw.Divider(),
                                                  pw.Row(
                                                    mainAxisSize:
                                                        pw.MainAxisSize.min,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Text(
                                                        p.type ==
                                                                ProblemeType.MAX
                                                            ? "Max"
                                                            : "Min",
                                                        style: pw.TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold),
                                                      ),
                                                      pw.SizedBox(width: 3),
                                                      pw.Text(
                                                        p.name,
                                                        style:
                                                            const pw.TextStyle(
                                                                fontSize: 14),
                                                      ),
                                                      pw.Padding(
                                                          padding: const pw
                                                                  .EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                          child: pw.Text(
                                                            "=",
                                                            style: pw.TextStyle(
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                                fontSize: 13),
                                                          )),
                                                      ...p.variables.map(
                                                        (element) =>
                                                            element.value == 0
                                                                ? pw.Container()
                                                                : pw.Row(
                                                                    mainAxisSize: pw
                                                                        .MainAxisSize
                                                                        .min,
                                                                    children: [
                                                                      element.value
                                                                              .isNegative
                                                                          ? pw.Padding(
                                                                              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                                                                              child: pw.Text("-", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
                                                                            )
                                                                          : p.variables.indexOf(element) == 0
                                                                              ? pw.SizedBox()
                                                                              : pw.Padding(
                                                                                  padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                                                                                  child: pw.Text("+", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13)),
                                                                                ),
                                                                      pw.Padding(
                                                                          padding: pw.EdgeInsets.only(bottom: 5),
                                                                          child: pw.RichText(
                                                                              text: pw.TextSpan(text: element.value.abs() == 1 ? "" : element.value.abs().toInt().toString(), children: [
                                                                            pw.TextSpan(
                                                                                text: element.name[0],
                                                                                style: pw.TextStyle(
                                                                                  fontSize: 13,
                                                                                  font: tff,
                                                                                )),
                                                                            //!Waarning might throw exception
                                                                            pw.TextSpan(
                                                                                text: element.name[1],
                                                                                style: pw.TextStyle(
                                                                                  fontSize: 10,
                                                                                  font: tff,
                                                                                )),
                                                                          ]))),
                                                                    ],
                                                                  ),
                                                      )
                                                    ],
                                                  ),
                                                  pw.SizedBox(height: 25),
                                                  pw.Text("Forme canonique",
                                                      style: const pw.TextStyle(
                                                        fontSize: 15,
                                                      )),
                                                  pw.Divider(),
                                                  p.pwtoFormCanoniqueWidget(
                                                      null, tff)
                                                ])); // Center
                                      }));
                                  if (path != null) {
                                    Constante.log.v(path);
                                    final file = File(path + "/example.pdf");
                                    await file.writeAsBytes(await pdf.save());
                                  }
                                  ///////////////////////////////////////////////////////////////////////////
//////////////////////////////P////////////////////////////////////
//////////////////////////////D//////////////////////////////////////////
//////////////////////////////F//////////////////
//////////////////////////////////////////////////
                                },
                                child: const Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.black12,
                                )),
                            const SizedBox(
                              width: 20,
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
                                      duration:
                                          const Duration(milliseconds: 500),
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
                          ]
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
                  // widget.probleme.type == ProblemeType.MAX
                  //     ?
                  SliverList(
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
                ],
              ),
            )));
  }
}
