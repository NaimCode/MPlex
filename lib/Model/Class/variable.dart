import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Widget getWidget() {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Get.theme.scaffoldBackgroundColor),
        child: RichText(
            text: TextSpan(
                text: value.toInt().toString(),
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 16),
                children: [
              TextSpan(
                  text: " " + name[0], style: Get.theme.textTheme.headline1),
              //!Waarning might throw exception
              TextSpan(
                text: name[1],
                style: Get.theme.textTheme.headline1!.copyWith(
                    fontSize: 12,
                    color: Get.theme.primaryColor.withOpacity(0.6)),
              ),
            ])));
  }

  @override
  String toString() => '$name=$value';
}
