import 'package:mplex/Model/Class/variable.dart';
import 'package:mplex/Model/enum.dart';

class Contrainte {
  List<Variable> variables;
  Inegalite inegalite;
  double value;
  Contrainte({
    required this.variables,
    required this.inegalite,
    required this.value,
  });
}
