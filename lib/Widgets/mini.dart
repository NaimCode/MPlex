import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardForm extends StatelessWidget {
  CardForm({Key? key, required this.widget}) : super(key: key);
  Widget widget;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Get.theme.backgroundColor,
        ),
        child: widget,
      ),
    );
  }
}

class VariableNameWidget extends StatelessWidget {
  const VariableNameWidget({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "x",
          style: Get.theme.textTheme.headline1!.copyWith(fontSize: 22),
        ),
        TextSpan(
          text: " $number",
          style: Get.theme.textTheme.headline1!
              .copyWith(color: Get.theme.primaryColor),
        ),
      ]),
    );
  }
}

class VariableNameWidget2 extends StatelessWidget {
  const VariableNameWidget2({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: number[0],
          style: Get.theme.textTheme.headline1!.copyWith(fontSize: 22),
        ),
        TextSpan(
          text: " ${number[1]}",
          style: Get.theme.textTheme.headline1!
              .copyWith(color: Get.theme.primaryColor),
        ),
      ]),
    );
  }
}

class InputMini extends StatelessWidget {
  const InputMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(9)),
      child: const Center(
        child: TextField(
          decoration: InputDecoration(hintText: "Z", border: InputBorder.none),
        ),
      ),
    );
  }
}
