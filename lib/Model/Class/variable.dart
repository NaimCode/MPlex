import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mplex/Config/fonction.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mplex/Model/Class/variable_condition.dart';
import 'package:mplex/Model/enum.dart';
part 'variable.g.dart';

@HiveType(typeId: 0)
class Variable {
  @HiveField(0)
  String name;
  @HiveField(1)
  double value;
  @HiveField(2)
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
    return value.ceil().toString().length > 7
        ? value < 0
            ? "-M"
            : "M"
        : value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
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

  Widget getNameWidget2({required bool isLast}) {
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
          TextSpan(
            text: isLast ? "" : ",",
            style: Get.theme.textTheme.headline1!
                .copyWith(fontSize: 17, color: Colors.grey[700]),
          ),
        ]));
  }

  pw.Widget pwgetNameWidget2({required bool isLast, final tff}) {
    return pw.RichText(
        text: pw.TextSpan(
            text: name[0],
            style: pw.TextStyle(
              fontSize: 13,
              font: tff,
            ),
            children: [
          //!Waarning might throw exception
          pw.TextSpan(
            text: name[1],
            style: pw.TextStyle(
              fontSize: 10,
              font: tff,
            ),
          ),
          pw.TextSpan(
            text: isLast ? "" : ",",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13),
          ),
        ]));
  }

  Widget getNameValueWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
            text: TextSpan(
                text: name[0],
                style: Get.theme.textTheme.headline1,
                children: [
              //!Waarning might throw exception
              TextSpan(
                text: name[1],
                style: Get.theme.textTheme.headline1!.copyWith(
                    fontSize: 15,
                    color: Get.theme.primaryColor.withOpacity(0.6)),
              ),
            ])),
        const Padding(
          padding: EdgeInsets.only(right: 6, left: 6, top: 5),
          child: FaIcon(FontAwesomeIcons.equals, size: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            removeDecimalZeroFormat(),
            style: Get.textTheme.subtitle2,
          ),
        )
      ],
    );
  }

  Widget getNameValueWidget2(double v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
            text: TextSpan(
                text: name[0],
                style: Get.theme.textTheme.headline1,
                children: [
              //!Waarning might throw exception
              TextSpan(
                text: name[1],
                style: Get.theme.textTheme.headline1!.copyWith(
                    fontSize: 15,
                    color: Get.theme.primaryColor.withOpacity(0.6)),
              ),
            ])),
        const Padding(
          padding: EdgeInsets.only(right: 6, left: 6, top: 5),
          child: FaIcon(FontAwesomeIcons.equals, size: 10),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            Fonction.removeDecimalZeroFormat(v),
            style: Get.textTheme.subtitle2,
          ),
        )
      ],
    );
  }

  @override
  String toString() => '$name=$value';

  Variable copyWith({
    String? name,
    double? value,
    VariableType? variableType,
  }) {
    return Variable(
      variableType: variableType ?? this.variableType,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'variableType': variableType,
      'name': name,
      'value': value,
    };
  }

  factory Variable.fromMap(Map<String, dynamic> map) {
    return Variable(
      variableType: map["variableType"] ?? VariableType.DECISION,
      name: map['name'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Variable.fromJson(String source) =>
      Variable.fromMap(json.decode(source));
}
