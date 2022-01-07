import 'dart:math';

import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';

class Algorithme {
  Tableau? maximisation(Tableau tableau) {
    return null;
  }

  SolutionType resolution({required Tableau tableau}) {
    // print("VDB");
    // print(tableau.vdb);
    // print("st");
    // print(tableau.st);
    // print("matrice");
    // print(tableau.variables);
    // print("cj");
    // print(tableau.cj);
    // print("zj");
    // print(tableau.zj);
    // print("cj-zj");
    // print(tableau.cj_zj);
    if (tableau.numero >= 3
        // tableau.cj_zj.every((element) => element <= 0)
        ) {
      print(tableau.vdb);
      return SolutionType.FINAL;
    } else {
      print(tableau.vdb);
      int variableEntrante = tableau.getVariableEntrante();

      // print("Variable entrante $variableEntrante");
      List<Variable> colonne =
          tableau.getColonnePivot(variableEntrante: variableEntrante);

      // print("Colonne $colonne");
      int pivot = tableau.getPivot(colonne: colonne);

      //print("Pivot $pivot");
      tableau.updateVDB(pivot: pivot, variableEntrante: variableEntrante);

      // print("udapte vdb");
      tableau.updateVariablesAndST(
          pivot: pivot, variableEntrante: variableEntrante);

      //print("udapte Variables");
      tableau.updateZj();

      //  print("udapte zj");
      tableau.updateCjZj();
      //print(tableau.cj);
      // print("udapte cj-zj");
    }

    return resolution(tableau: tableau.copyWith(numero: tableau.numero + 1));
  }
}
