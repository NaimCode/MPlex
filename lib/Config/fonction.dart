import 'package:get/get.dart';
import 'package:mplex/Model/Class/probleme.dart';
import 'package:mplex/Pages/Optimisation/index.dart';
import 'package:mplex/Pages/Resolution/controller.dart';

import '../page.dart';

class Fonction {
  static void toOptimisation({required Probleme probleme}) {
    Get.to(
        () => Root(
              rightSide: Optimisation(probleme: probleme),
            ),
        preventDuplicates: true,
        duration: const Duration(milliseconds: 400),
        transition: Transition.downToUp,
        fullscreenDialog: true,
        routeName: "/optimisation/${probleme.name}");
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
