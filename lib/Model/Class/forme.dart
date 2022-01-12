import 'package:hive_flutter/adapters.dart';
import 'package:mplex/Model/Class/contrainte.dart';
import 'package:mplex/Model/enum.dart';
part 'forme.g.dart';

@HiveType(typeId: 3)
class Forme {
  @HiveField(0)
  List<Contrainte> contraintes;
  @HiveField(1)
  FormeType type;
  Forme({
    required this.type,
    required this.contraintes,
  });

  Forme copyWith({List<Contrainte>? contraintes, FormeType? type}) {
    return Forme(
      type: type ?? this.type,
      contraintes:
          contraintes ?? this.contraintes.map((e) => e.copyWith()).toList(),
    );
  }
}
