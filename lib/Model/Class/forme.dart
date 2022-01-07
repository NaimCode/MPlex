import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/enum.dart';

class Forme {
  List<Contrainte> contraintes;
  FormeType type;
  Forme({
    required this.type,
    required this.contraintes,
  });
}
