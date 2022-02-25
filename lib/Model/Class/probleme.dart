// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Config/const.dart';

import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';

import 'contrainte.dart';
import 'forme.dart';
import 'variable.dart';

part 'probleme.g.dart';

@HiveType(typeId: 2)
class Probleme {
  @HiveField(1)
  String nameVariableEcart = "e";
  @HiveField(5)
  String nameVariableArtificiel = "a";
  @HiveField(2)
  String name;
  @HiveField(3)
  Forme forme;
  @HiveField(4)
  ProblemeType type;
  @HiveField(0)
  List<Variable> variables;
  Probleme({
    required this.forme,
    required this.type,
    required this.name,
    required this.variables,
  });

  Probleme toDual() {
    List<Variable> dualVariables = [];
    for (int i = 0; i < forme.contraintes.length; i++) {
      dualVariables.add(Variable(
          name: dualVariableName + (i + 1).toString(),
          value: forme.contraintes[i].value,
          variableType: VariableType.DECISION));
    }
    List<Contrainte> dualContraintes = [];
    for (int i = 0; i < variables.length; i++) {
      List<Variable> tempVariable = [];
      for (int j = 0; j < forme.contraintes.length; j++) {
        tempVariable.add(Variable(
            name: dualVariableName + (j + 1).toString(),
            value: forme.contraintes[j].variables[i].value,
            variableType: VariableType.DECISION));
      }
      if (tempVariable.every((element) => element.value == 0)) {
      } else {
        dualContraintes.add(Contrainte(
            variables: tempVariable,
            inegalite: Inegalite.INF_EGAL,
            value: variables[i].value));
      }
    }
    return Probleme(
        forme: Forme(type: FormeType.CANONIQUE, contraintes: dualContraintes),
        type: ProblemeType.MAX,
        name: "W",
        variables: dualVariables);
  }

  Probleme toStandart() {
    try {
      if (forme.type != FormeType.STANDARD) {
        Probleme probleme = this;
        if (type == ProblemeType.MAX) {
          for (int i = 0; i < probleme.forme.contraintes.length; i++) {
            //Changement des inegalité des contraintes
            probleme.forme.contraintes[i].inegalite = Inegalite.EGAL;
            probleme.forme.contraintes[i].variables.add(Variable(
                name: "$nameVariableEcart${i + 1}",
                value: 1, //eValue,
                variableType: VariableType.ECART));
          }
        } else {
          for (int i = 0; i < probleme.forme.contraintes.length; i++) {
            probleme.forme.contraintes[i].inegalite = Inegalite.EGAL;
            probleme.forme.contraintes[i].variables.add(Variable(
                name: "$nameVariableEcart${i + 1}",
                value: -1, //eValue,
                variableType: VariableType.ECART));

            probleme.forme.contraintes[i].variables.add(Variable(
                name: "$nameVariableArtificiel${i + 1}",
                value: 1, //eValue,
                variableType: VariableType.ARTIFICIELLE));

            probleme.variables.add(Variable(
                name: "$nameVariableEcart${i + 1}",
                value: 0, //eValue,
                variableType: VariableType.ECART));
          }
          for (int i = 0; i < probleme.forme.contraintes.length; i++) {
            probleme.variables.add(Variable(
                name: "$nameVariableArtificiel${i + 1}",
                value: 1 / 0, //eValue,
                variableType: VariableType.ARTIFICIELLE));
          }
        }
      } else {
        throw Exception(Exceptions.DEJA_STANDARD);
      }
    } catch (e) {
      print(e);
    }
    return this;
  }

  Tableau toTableau() {
    if (type == ProblemeType.MAX) {
      Tableau? tableau;
      Probleme probleme = toStandart();
      probleme.forme.contraintes.map((e) => e.variables.last.value).toList();
      List<double> cj = probleme.variables.map((e) => e.value).toList();
      cj.addAll(List.filled(probleme.forme.contraintes.length, 0));
      List<double> zj = List.filled(cj.length, 0);

      List<double> cj_zj = cj.map((e) => e).toList();
      List<Variable> vdb = probleme.forme.contraintes
          .map((e) => Variable(
              name: e.variables.last.name,
              value: 0,
              variableType: e.variables.last.variableType))
          .toList();
      List<double> st = probleme.forme.contraintes.map((e) => e.value).toList();
      List<Variable> ecart =
          probleme.forme.contraintes.map((e) => e.variables.last).toList();

      List<List<Variable>> matrice =
          probleme.forme.contraintes.map((e) => e.variables).toList();
      for (int i = 0; i < matrice.length; i++) {
        matrice[i].removeLast();
        for (int j = 0; j < ecart.length; j++) {
          if (j == i) {
            matrice[i].add(ecart[j]);
          } else {
            matrice[i].add(Variable(
                name: ecart[j].name,
                value: 0,
                variableType: VariableType.ECART));
          }
        }
      }
      tableau = Tableau(
          numero: 1,
          cj: cj,
          zj: zj,
          cj_zj: cj_zj,
          vdb: vdb,
          st: st,
          variables: matrice,
          problemeType: type);

      return tableau;
    } else {
      Tableau? tableau;
      Probleme probleme = toStandart();

      List<double> cj = probleme.variables.map((e) => e.value).toList();

      List<double> cj_zj = cj.map((e) => e).toList();
      List<Variable> vdb = probleme.forme.contraintes
          .map((e) => e.variables.last.copyWith(
              value: probleme.variables
                  .singleWhere(
                      (element) => e.variables.last.name == element.name)
                  .value))
          .toList();
      List<double> st = probleme.forme.contraintes.map((e) => e.value).toList();

      List<List<Variable>> matrice = [];
      for (int j = 0; j < probleme.forme.contraintes.length; j++) {
        List<Variable> temp = [];
        for (int i = 0; i < probleme.variables.length; i++) {
          temp.add(probleme.forme.contraintes[j].variables
                  .any((e) => e.name == probleme.variables[i].name)
              ? probleme.forme.contraintes[j].variables.singleWhere(
                  (element) => element.name == probleme.variables[i].name)
              : probleme.variables[i].copyWith(value: 0));
        }
        matrice.add(temp);
      }
      List<double> zj = List.filled(cj.length, 0);
      for (int i = 0; i < zj.length; i++) {
        double temp = 0;
        for (int j = 0; j < matrice.length; j++) {
          temp += vdb[j].value * matrice[j][i].value;
        }

        zj[i] = temp;
      }

      tableau = Tableau(
          numero: 1,
          cj: cj,
          zj: zj,
          cj_zj: cj_zj,
          vdb: vdb,
          st: st,
          variables: matrice,
          problemeType: type);

      return tableau;
    }
  }

  Widget getApercuFonctionObjective() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          type == ProblemeType.MAX ? "Max" : "Min",
          style: Get.theme.textTheme.headline6!
              .copyWith(color: Get.theme.focusColor),
        ),
        const SizedBox(width: 3),
        Text(
          name,
          style: Get.textTheme.headline6,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: FaIcon(FontAwesomeIcons.equals, size: 10),
        ),
        ...variables.map((element) =>
            element.getWidgetWithoutContainer(variables.indexOf(element) == 0))
      ],
    );
  }

  Widget getApercuFormeCanonique() {
    List<Contrainte> cons = [];
    for (int i = 0; i < forme.contraintes.length; i++) {
      cons.add(forme.contraintes[i].copyWith());
    }
    for (int i = 0; i < cons.length; i++) {
      cons[i].variables.removeWhere((element) => element.value == 0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: cons
            .map((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...e.variables.map((element) =>
                        element.getWidgetWithoutContainer(
                            e.variables.indexOf(element) == 0)),
                    Transform.scale(
                      scale: 0.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: e.getInegalityIcon(),
                      ),
                    ),
                    Text(e.value.toInt().toString(),
                        style: Get.textTheme.bodyText2!.copyWith(fontSize: 17))
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget toFonctionObjectiveWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          type == ProblemeType.MAX ? "Max" : "Min",
          style: Get.theme.textTheme.headline6!
              .copyWith(color: Get.theme.focusColor),
        ),
        const SizedBox(width: 3),
        Text(
          name,
          style: Get.textTheme.headline6!.copyWith(fontSize: 18),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: FaIcon(FontAwesomeIcons.equals, size: 10),
        ),
        ...variables.map((element) =>
            element.getWidgetWithoutContainer(variables.indexOf(element) == 0))
      ],
    );
  }

  Widget toFormCanoniqueWidget(Probleme? probleme) {
    Probleme p = probleme ?? copyWith();
    List<Contrainte> cons = [];
    for (int i = 0; i < p.forme.contraintes.length; i++) {
      cons.add(p.forme.contraintes[i].copyWith());
    }
    for (int i = 0; i < cons.length; i++) {
      cons[i].variables.removeWhere((element) => element.value == 0);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: cons
            .map((e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...e.variables.map((element) =>
                        element.getWidgetWithoutContainer(
                            e.variables.indexOf(element) == 0)),
                    Transform.scale(
                      scale: 0.6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: e.getInegalityIcon(),
                      ),
                    ),
                    Text(e.value.toInt().toString(),
                        style: Get.textTheme.bodyText2!.copyWith(fontSize: 17))
                  ],
                ))
            .toList(),
      ),
    );
  }

  Probleme copyWith({
    String? nameVariableEcart,
    String? name,
    Forme? forme,
    List<Variable>? variables,
  }) {
    return Probleme(
      type: type,
      name: name ?? this.name,
      forme: forme ?? this.forme.copyWith(),
      variables: variables ?? this.variables.map((e) => e).toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Probleme &&
        other.nameVariableEcart == nameVariableEcart &&
        other.name == name &&
        other.forme == forme &&
        listEquals(other.variables, variables);
  }

  @override
  int get hashCode {
    return nameVariableEcart.hashCode ^
        name.hashCode ^
        forme.hashCode ^
        variables.hashCode;
  }
}
