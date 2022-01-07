import 'package:mplex/Model/Class/variable_condition.dart';
import 'package:mplex/Model/enum.dart';

class Variable {
  String name;
  double value;
  VariableType variableType;
  VariableCondition? condition;
  Variable(
      {required this.name,
      required this.value,
      required this.variableType,
      this.condition});

  @override
  String toString() => 'Variable(name: $name, value: $value)';
}
