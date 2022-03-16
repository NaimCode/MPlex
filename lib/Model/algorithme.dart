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

    yield Tableau(
        numero: tab.numero,
        cj: tab.cj.map((e) => e).toList(),
        zj: tab.zj.map((e) => e).toList(),
        cj_zj: tab.cj_zj.map((e) => e).toList(),
        vdb: tab.vdb.map((e) => e).toList(),
        st: tab.st.map((e) => e).toList(),
        variables: tab.variables
            .map((e) => e
                .map((e) => Variable(
                    name: e.name, value: e.value, variableType: e.variableType))
                .toList())
            .toList(),
        problemeType: tab.problemeType);
    while (verification(tableau: tab, type: probleme.type) ==
        SolutionType.OPTIMAL) {
      tab = resolution(tableau: tab.copyWith(numero: tab.numero + 1));
      yield Tableau(
          numero: tab.numero,
          cj: tab.cj.map((e) => e).toList(),
          zj: tab.zj.map((e) => e).toList(),
          cj_zj: tab.cj_zj.map((e) => e).toList(),
          vdb: tab.vdb.map((e) => e).toList(),
          st: tab.st.map((e) => e).toList(),
          variables: tab.variables
              .map((e) => e
                  .map((e) => Variable(
                      name: e.name,
                      value: e.value,
                      variableType: e.variableType))
                  .toList())
              .toList(),
          problemeType: tab.problemeType);
    }
  }

  Tableau resolution({required Tableau tableau}) {
    int variableEntrante = tableau.getVariableEntrante();

    List<Variable> colonne =
        tableau.getColonnePivot(variableEntrante: variableEntrante);

    int? pivot = tableau.getPivot(colonne: colonne);

    // Constante.log.d("pivot : $pivot , v : $variableEntrante");
    if (pivot != null) {
      tableau
        ..updateVDB(pivot: pivot, variableEntrante: variableEntrante)
        ..updateVariablesAndST(pivot: pivot, variableEntrante: variableEntrante)
        ..updateZj()
        ..updateCjZj();
    } else {
      tableau.copyWith(isBorne: false);
    }

    // return resolution(
    //     tableau: tableau.copyWith(numero: tableau.numero + 1));

    return tableau;
  }

  SolutionType verification(
      {required Tableau tableau, required ProblemeType type}) {
    if (tableau.cj_zj.every((element) => element <= 0))
      return SolutionType.FINAL;
    else {
      bool isBorne = tableau.isBorne == null ? true : tableau.isBorne!;
      if (tableau.numero >= 20 || !isBorne) {
        return SolutionType.IMPOSSIBLE;
      } else
        return SolutionType.OPTIMAL;
    }
  }
}
