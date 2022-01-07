import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/Class/forme.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';

Variable x1Test =
    Variable(name: "x1", value: 7, variableType: VariableType.DECISION);
Variable x2Test =
    Variable(name: "x2", value: 5, variableType: VariableType.DECISION);

List<Contrainte> contraintesTest = [
  Contrainte(variables: [
    Variable(name: "x1", value: 1, variableType: VariableType.DECISION),
    Variable(name: "x2", value: 0, variableType: VariableType.DECISION),
  ], inegalite: Inegalite.INF_EGAL, value: 300),
  Contrainte(variables: [
    Variable(name: "x1", value: 0, variableType: VariableType.DECISION),
    Variable(name: "x2", value: 1, variableType: VariableType.DECISION),
  ], inegalite: Inegalite.INF_EGAL, value: 400),
  Contrainte(variables: [
    Variable(name: "x1", value: 1, variableType: VariableType.DECISION),
    Variable(name: "x2", value: 1, variableType: VariableType.DECISION),
  ], inegalite: Inegalite.INF_EGAL, value: 500),
  Contrainte(variables: [
    Variable(name: "x1", value: 2, variableType: VariableType.DECISION),
    Variable(name: "x2", value: 1, variableType: VariableType.DECISION),
  ], inegalite: Inegalite.INF_EGAL, value: 700),
];
Forme formeTest =
    Forme(type: FormeType.CANONIQUE, contraintes: contraintesTest);

Probleme problemeTest = Probleme(
    forme: formeTest,
    type: ProblemeType.MAX,
    name: "Z",
    variables: [x1Test, x2Test]);


// Variable x1Test =
//     Variable(name: "x1", value: 3, variableType: VariableType.DECISION);
// Variable x2Test =
//     Variable(name: "x2", value: 2, variableType: VariableType.DECISION);
// Variable x3Test =
//     Variable(name: "x3", value: 4, variableType: VariableType.DECISION);

// List<Contrainte> contraintesTest = [
//   Contrainte(variables: [
//     Variable(name: "x1", value: 1, variableType: VariableType.DECISION),
//     Variable(name: "x2", value: 1, variableType: VariableType.DECISION),
//     Variable(name: "x3", value: 2, variableType: VariableType.DECISION)
//   ], inegalite: Inegalite.INF_EGAL, value: 4),
//   Contrainte(variables: [
//     Variable(name: "x1", value: 2, variableType: VariableType.DECISION),
//     Variable(name: "x2", value: 3, variableType: VariableType.DECISION),
//     Variable(name: "x3", value: 0, variableType: VariableType.DECISION)
//   ], inegalite: Inegalite.INF_EGAL, value: 4),
//   Contrainte(variables: [
//     Variable(name: "x1", value: 2, variableType: VariableType.DECISION),
//     Variable(name: "x2", value: 1, variableType: VariableType.DECISION),
//     Variable(name: "x3", value: 3, variableType: VariableType.DECISION)
//   ], inegalite: Inegalite.INF_EGAL, value: 4),
// ];
// Forme formeTest =
//     Forme(type: FormeType.CANONIQUE, contraintes: contraintesTest);

// Probleme problemeTest = Probleme(
//     forme: formeTest,
//     type: ProblemeType.MAX,
//     name: "Z",
//     variables: [x1Test, x2Test, x3Test]);
