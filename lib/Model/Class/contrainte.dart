import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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

  Widget getWidget({required var funct}) {
    RxBool isHover = false.obs;
    return MouseRegion(
      onEnter: (v) => isHover.value = true,
      onExit: (v) => isHover.value = false,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Get.theme.scaffoldBackgroundColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: variables
                    .map((element) => element.getWidgetWithoutContainer(
                        variables.indexOf(element) == 0))
                    .toList()
                    .cast(),
              )),
          const SizedBox(width: 20),
          getInegalityIcon(),
          const SizedBox(width: 20),
          getValueWidget(),
          const Spacer(),
          Obx(() => Visibility(
              visible: isHover.value,
              child: IconButton(
                  tooltip: "Supprimer cette contrainte",
                  onPressed: funct,
                  icon: FaIcon(
                    FontAwesomeIcons.timesCircle,
                    size: 18,
                    color: Colors.red[900]!.withOpacity(0.8),
                  ))))
        ],
      ),
    );
  }

  Widget getInegalityIcon() {
    switch (inegalite) {
      case Inegalite.INF_EGAL:
        return const FaIcon(FontAwesomeIcons.lessThanEqual);
      case Inegalite.INF:
        return const FaIcon(FontAwesomeIcons.lessThan);
      case Inegalite.SUP_EGAL:
        return const FaIcon(FontAwesomeIcons.greaterThanEqual);
      case Inegalite.SUP:
        return const FaIcon(FontAwesomeIcons.greaterThan);
      case Inegalite.EGAL:
        return const FaIcon(FontAwesomeIcons.equals);
      default:
        return const FaIcon(FontAwesomeIcons.lessThanEqual);
    }
  }

  Widget getValueWidget() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Get.theme.scaffoldBackgroundColor),
        child: Text(
          value.toInt().toString(),
          style: Get.textTheme.bodyText2!.copyWith(fontSize: 20),
        ));
  }
}
