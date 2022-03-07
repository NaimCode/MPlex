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
        List<Variable> l = [];
        for (int i = 0; i < probleme.forme.contraintes.length; i++) {
          //Changement des inegalité des contraintes
          double val = 1;
          switch (probleme.forme.contraintes[i].inegalite) {
            case Inegalite.INF_EGAL:
              val = 1;
              break;
            case Inegalite.SUP_EGAL:
              val = -1;
              break;
            case Inegalite.EGAL:
              val = 0;
              break;
            default:
              val = 1;
          }
          probleme.forme.contraintes[i].inegalite = Inegalite.EGAL;
          if (val != 0) {
            Variable v = Variable(
                name: "$nameVariableEcart${i + 1}",
                value: val, //eValue,
                variableType: VariableType.ECART);
            l.add(v);
            probleme.forme.contraintes[i].variables.add(v);
          }
          if (val != 1) {
            Variable v = Variable(
                name: "$nameVariableArtificiel${i + 1}",
                value: 1, //eValue,
                variableType: VariableType.ARTIFICIELLE);
            l.add(v);
            probleme.forme.contraintes[i].variables.add(v);
          }
        }
        List<Variable> tempX = l
            .where((element) => element.variableType == VariableType.ECART)
            .toList();
        List<Variable> tempY = l
            .where(
                (element) => element.variableType == VariableType.ARTIFICIELLE)
            .toList();
        probleme.variables.addAll(tempX.map((e) => e.copyWith(value: 0)));
        probleme.variables.addAll(tempY.map((e) => e.copyWith(value: M)));
      }
    } catch (e) {
      print(e);
    }
    return this;
  }

  Tableau toTableau() {
    Tableau? tableau;
    Probleme probleme = toStandart();
//
    List<double> cj = probleme.variables.map((e) => e.value).toList();
    List<double> zj = List.filled(cj.length, 0);
    List<double> cj_zj = cj.map((e) => e).toList();
//

    List<Variable> vdb = probleme.variables
        .getRange(probleme.variables.length - probleme.forme.contraintes.length,
            probleme.variables.length)
        .toList();
//
    List<double> st = probleme.forme.contraintes.map((e) => e.value).toList();
    List<List<Variable>> matrice = [];
    Constante.log.i(probleme.variables);
    for (int i = 0; i < probleme.forme.contraintes.length; i++) {
      Constante.log.v(probleme.forme.contraintes[i].variables);
      List<Variable> temp = [];
      for (int j = 0; j < probleme.variables.length; j++) {
        if (probleme.forme.contraintes[i].variables
            .any((element) => element.name == probleme.variables[j].name))
          temp.add(probleme.forme.contraintes[i].variables.firstWhere(
              (element) => element.name == probleme.variables[j].name));
        else {
          temp.add(probleme.variables[j].copyWith(value: 0));
        }
      }
      matrice.add(temp);
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
