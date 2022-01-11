import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Get.theme.scaffoldBackgroundColor),
        child: RichText(
            text: TextSpan(
                text: value.toInt().toString(),
                style: Get.textTheme.bodyText2!.copyWith(fontSize: 20),
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

  Widget getWidgetWithoutContainer(bool isFirst) {
    return Visibility(
      visible: value != 0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          value.isNegative
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: FaIcon(
                    FontAwesomeIcons.minus,
                    size: 10,
                  ),
                )
              : Visibility(
                  visible: !isFirst,
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 10,
                      ))),
          RichText(
              text: TextSpan(
                  text: value.abs() == 1 ? "" : value.abs().toInt().toString(),
                  style: Get.textTheme.bodyText2!.copyWith(fontSize: 20),
                  children: [
                TextSpan(text: name[0], style: Get.theme.textTheme.headline1),
                //!Waarning might throw exception
                TextSpan(
                  text: name[1],
                  style: Get.theme.textTheme.headline1!.copyWith(
                      fontSize: 12,
                      color: Get.theme.primaryColor.withOpacity(0.6)),
                ),
              ])),
        ],
      ),
    );
  }

  String removeDecimalZeroFormat() {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  }

  Widget getNameWidget() {
    return RichText(
        text: TextSpan(
            text: name[0],
            style: Get.theme.textTheme.headline1,
            children: [
          //!Waarning might throw exception
          TextSpan(
            text: name[1],
            style: Get.theme.textTheme.headline1!.copyWith(
                fontSize: 15, color: Get.theme.primaryColor.withOpacity(0.6)),
          ),
        ]));
  }

  @override
  String toString() => '$name=$value';
}
