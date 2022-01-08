import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mplex/Config/databse.dart';
import 'package:mplex/Config/get_controller.dart';
import 'package:mplex/Config/menu.dart';
import 'package:mplex/Config/theme.dart';
import 'package:provider/provider.dart';
import 'darkModeButton.dart';
import 'logo.dart';

class LeftSide extends StatefulWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  _LeftSideState createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: MyGetController.isCollapse.value ? 100 : 210,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: MyGetController.isCollapse.value ? 90 : 200,
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
                padding: EdgeInsets.symmetric(
                    horizontal: MyGetController.isCollapse.value ? 5 : 15,
                    vertical: 10),
                child: Column(
                  children: [
                    // ignore: prefer_const_constructors
                    Logo(),
                    const Divider(),
                    Menu().getWidget(),
                    const Divider(),
                    DarkModeButton()
                  ],
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Get.theme.scaffoldBackgroundColor),
                          color: Colors.white),
                      child: SizedBox(
                        width: 25,
                        height: 40,
                        child: IconButton(
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            padding: const EdgeInsets.all(0),
                            onPressed: () => MyGetController.isCollapse.value =
                                !MyGetController.isCollapse.value,
                            icon: Icon(MyGetController.isCollapse.value
                                ? Icons.navigate_next
                                : Icons.navigate_before)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
