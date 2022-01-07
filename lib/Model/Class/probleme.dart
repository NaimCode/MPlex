// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:mplex/Model/Class/tableau.dart';
import 'package:mplex/Model/enum.dart';

import 'forme.dart';
import 'variable.dart';

class Probleme {
  String nameVariableEcart = "e";
  String name;
  Forme forme;
  ProblemeType type;
  List<Variable> variables;
  Probleme({
    required this.forme,
    required this.type,
    required this.name,
    required this.variables,
  });

  Probleme toStandart() {
    try {
      if (forme.type != FormeType.STANDARD) {
        Probleme probleme = this;
        for (int i = 0; i < probleme.forme.contraintes.length; i++) {
          //Changement des inegalité des contraintes
          probleme.forme.contraintes[i].inegalite = Inegalite.EGAL;
          probleme.forme.contraintes[i].variables.add(Variable(
              name: "$nameVariableEcart${i + 1}",
              value: 1,
              variableType: VariableType.ECART));
        }
      } else {
        throw Exception(Exceptions.DEJA_STANDARD);
      }
    } catch (e) {
      print(e);
    }
    return this;
  }

  Tableau? toTableau() {
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

    //print(ecart);
    List<List<Variable>> matrice =
        probleme.forme.contraintes.map((e) => e.variables).toList();
    for (int i = 0; i < matrice.length; i++) {
      matrice[i].removeLast();
      for (int j = 0; j < ecart.length; j++) {
        if (j == i) {
          matrice[i].add(ecart[j]);
        } else {
          matrice[i].add(Variable(
              name: ecart[j].name, value: 0, variableType: VariableType.ECART));
        }
      }
    }

    // for (int i = 0; i < probleme.forme.contraintes.length; i++) {
    //   for (int j = 0; j < ecart.length; j++) {
    //     if (!matrice[i].any((element) => element.name == ecart[j].name)) {
    //       matrice[i].add(Variable(
    //           name: ecart[j].name, value: 0, variableType: VariableType.ECART));
    //     }
    //   }
    // }

    tableau = Tableau(
        numero: 1,
        cj: cj,
        zj: zj,
        cj_zj: cj_zj,
        vdb: vdb,
        st: st,
        variables: matrice,
        problemeType: type);

    // try {
    //   if (tableau == null) {
    //     throw Exception(Exceptions.ERREUR_CREATION_TABLEAU);
    //   }
    // } catch (e) {
    //   print(e);

    // }
    return tableau;
  }
}
