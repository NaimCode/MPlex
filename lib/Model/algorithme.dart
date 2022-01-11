// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';

import 'Class/probleme.dart';

class Algorithme {
  Tableau? maximisation(Tableau tableau) {
    return null;
  }

  Iterable<Tableau> start({required Probleme probleme}) sync* {
    Tableau tab = probleme.toTableau();

    // yield tab.copyWith();
    while (verification(tableau: tab) != SolutionType.FINAL) {
      yield resolution(tableau: tab.copyWith(numero: tab.numero + 1));
    }
  }

  Tableau resolution({required Tableau tableau}) {
    //Constante.log.i(tableau);

    int variableEntrante = tableau.getVariableEntrante();
    List<Variable> colonne =
        tableau.getColonnePivot(variableEntrante: variableEntrante);
    int pivot = tableau.getPivot(colonne: colonne);
    tableau.updateVDB(pivot: pivot, variableEntrante: variableEntrante);
    tableau.updateVariablesAndST(
        pivot: pivot, variableEntrante: variableEntrante);
    tableau.updateZj();
    tableau.updateCjZj();

    // return resolution(
    //     tableau: tableau.copyWith(numero: tableau.numero + 1));

    return tableau;
  }

  SolutionType verification({required Tableau tableau}) {
    if (tableau.cj_zj.every((element) => element <= 0))
      return SolutionType.FINAL;
    else
      return SolutionType.OPTIMAL;
  }
}
