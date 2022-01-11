import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/enum.dart';

class Forme {
  List<Contrainte> contraintes;
  FormeType type;
  Forme({
    required this.type,
    required this.contraintes,
  });

  Forme copyWith({List<Contrainte>? contraintes, FormeType? type}) {
    return Forme(
      type: type ?? this.type,
      contraintes: contraintes ?? this.contraintes.map((e) => e.copyWith()).toList(),
    );
  }
}
