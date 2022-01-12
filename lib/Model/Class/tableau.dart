// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'dart:math';

import 'package:mplex/Model/Class/solution.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/constante.dart';
import 'package:mplex/Model/enum.dart';

class Tableau {
  int numero;
  final List<double> cj;
  List<double> zj;
  List<double> cj_zj;
  List<Variable> vdb;
  List<double> st;
  List<List<Variable>> variables;
  ProblemeType problemeType;
  Tableau({
    required this.numero,
    required this.cj,
    required this.zj,
    required this.cj_zj,
    required this.vdb,
    required this.st,
    required this.variables,
    required this.problemeType,
  });

  Solution toSolution() {
    double val = 0;

    List<Variable> v = [];
    return Solution(variable: v, value: val);
  }

  double getZ() {
    double value = 0;
    for (int i = 0; i < vdb.length; i++) {
      if (vdb[i].variableType == VariableType.DECISION) {
        value += vdb[i].value * st[i];
      }

      //st[variables[0].indexWhere((element) => element.name == vdb[i].name)];
    }
    return value;
  }

  int getVariableEntrante() {
    return this.cj_zj.indexOf(this.cj_zj.reduce(max));
  }

  List<Variable> getColonnePivot({required int variableEntrante}) {
    return this
        .variables
        .map((e) =>
            e.where((element) => e.indexOf(element) == variableEntrante).first)
        .toList();
  }

  int getPivot({required List<Variable> colonne}) {
    List<Map<int, double>> rapport = [];

    for (int i = 0; i < colonne.length; i++) {
      rapport.add({i: st[i] / colonne[i].value});
    }
    // Constante.log.v(temp);
    // temp.skipWhile((value) => value <= 0);
    // Constante.log.v(temp);
    for (int i = 0; i < rapport.length; i++) {
      if (rapport[i].values.first <= 0) {
        rapport.removeAt(i);
      }
    }
    Map<int, double> index = rapport.first;
    for (int i = 0; i < rapport.length; i++) {
      index =
          index.values.first >= rapport[i].values.first ? rapport[i] : index;
    }
    return index.keys.first;
  }

  void updateVDB({required int pivot, required int variableEntrante}) {
    this.vdb.replaceRange(pivot, pivot + 1, [
      Variable(
          name: variables[pivot][variableEntrante].name,
          value: cj[variableEntrante],
          variableType: variables[pivot][variableEntrante].variableType)
    ]);
    //print(vdb);
  }

  void updateVariablesAndST(
      {required int pivot, required int variableEntrante}) {
    double x = 1 / variables[pivot][variableEntrante].value;

    for (int i = 0; i < variables[pivot].length; i++) {
      variables[pivot][i].value *= x;
      st[pivot] *= x;
    }
    for (int i = 0; i < variables.length; i++) {
      if (i != pivot) {
        double y = variables[i][variableEntrante].value /
            variables[pivot][variableEntrante].value;
        st[i] -= y * st[pivot];
        for (int j = 0; j < variables[i].length; j++) {
          //!Suspect
          variables[i][j].value -= y * variables[pivot][j].value;
        }
      }
    }
  }

  void updateZj() {
    // print("avant zj $zj");
    for (int i = 0; i < zj.length; i++) {
      double temp = 0;
      for (int j = 0; j < variables.length; j++) {
        temp += vdb[j].value * variables[j][i].value;
      }

      zj[i] = temp;
    }
    //print("apres zj $zj");
  }

  void updateCjZj() {
    //  print("avant cj-zj $cj_zj");
    for (int i = 0; i < zj.length; i++) {
      cj_zj[i] = cj[i] - zj[i];
    }
    // print("avant cj-zj $cj_zj");
  }

  Tableau copyWith({
    int? numero,
    List<double>? cj,
    List<double>? zj,
    List<double>? cj_zj,
    List<Variable>? vdb,
    List<double>? st,
    List<List<Variable>>? variables,
    ProblemeType? problemeType,
  }) {
    return Tableau(
      numero: numero ?? this.numero,
      cj: cj ?? this.cj,
      zj: zj ?? this.zj,
      cj_zj: cj_zj ?? this.cj_zj,
      vdb: vdb ?? this.vdb,
      st: st ?? this.st,
      variables: variables ?? this.variables,
      problemeType: problemeType ?? this.problemeType,
    );
  }

  @override
  String toString() {
    return 'Tableau(numero: $numero, cj: $cj, zj: $zj, cj_zj: $cj_zj, vdb: $vdb, st: $st, variables: $variables, problemeType: $problemeType)';
  }
}
