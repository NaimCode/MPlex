// ignore_for_file: constant_identifier_names
import 'package:hive_flutter/adapters.dart';

part 'enum.g.dart';

@HiveType(typeId: 100)
enum Inegalite {
  @HiveField(0)
  SUP_EGAL,
  @HiveField(1)
  INF_EGAL,
  @HiveField(2)
  EGAL,
  @HiveField(3)
  SUP,
  @HiveField(4)
  INF,
  @HiveField(5)
  INDEFINI
}
@HiveType(typeId: 1)
enum VariableType {
  @HiveField(0)
  DECISION,
  @HiveField(1)
  ECART,
  @HiveField(2)
  ARTIFICIELLE
}
@HiveType(typeId: 99)
enum FormeType {
  @HiveField(0)
  CANONIQUE,
  @HiveField(1)
  STANDARD
}
@HiveType(typeId: 98)
enum ProblemeType {
  @HiveField(0)
  MAX,
  @HiveField(1)
  MIN
}
@HiveType(typeId: 97)
enum Exceptions {
  @HiveField(0)
  DEJA_STANDARD,
  @HiveField(1)
  ERREUR_CREATION_TABLEAU
}
@HiveType(typeId: 96)
enum SolutionType {
  @HiveField(0)
  FINAL,
  @HiveField(1)
  INITIAL,
  @HiveField(2)
  OPTIMAL,
  @HiveField(3)
  IMPOSSIBLE
}
