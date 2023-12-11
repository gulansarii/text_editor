import 'package:editor/controllers/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.put(HomeScreenController());
  @override
  void initState() {
    homeScreenController.isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        homeScreenController.updateStack();
        homeScreenController.isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Editor",
            style: TextStyle(
              color: Color.fromARGB(255, 54, 28, 98),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(
            onPressed: () {
              homeScreenController.undo();
            },
            icon: const Icon(Icons.undo),
            iconSize: 27,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () {
                homeScreenController.redo();
              },
              icon: const Icon(Icons.redo),
              iconSize: 27,
            ),
          )
        ],
      ),
      body: GetBuilder<HomeScreenController>(builder: (controller) {
        return homeScreenController.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 27,
                        width: Get.width,
                        child: const Text(
                          "  Text",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        focusNode: homeScreenController.focusNode,
                        style: TextStyle(
                          fontSize:
                              homeScreenController.textData["font_size"]![0],
                          fontWeight:
                              homeScreenController.textData["font_weight"]![0],
                          color: homeScreenController.textData["color"]![0],
                        ),
                        controller: homeScreenController.textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Write Something...',
                          contentPadding: const EdgeInsets.all(18),
                          filled: true,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.grey.shade200,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 27,
                        width: Get.width,
                        child: const Text(
                          "  Font",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(20),
                            value: homeScreenController.selectedValue,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  homeScreenController.selectedValue = newValue;
                                  if (newValue == 'Normal') {
                                    homeScreenController
                                        .updateFontWeight(FontWeight.normal);
                                  } else {
                                    homeScreenController
                                        .updateFontWeight(FontWeight.bold);
                                  }
                                });
                              }
                            },
                            icon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9),
                              child: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16.0,
                            ),
                            items: <String>[
                              'Normal',
                              'Bold',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text('$value'),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 40,
                            width: 50,
                            child: const Text(
                              " Size",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.bottomLeft,
                            height: 40,
                            width: 110,
                            child: const Text(
                              "Color",
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 55,
                            width: Get.width * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                            ),
                            child: DropdownButton<double>(
                              underline: const SizedBox(),
                              value: homeScreenController
                                  .textData["font_size"]![0],
                              onChanged: (double? newSize) {
                                if (newSize != null) {
                                  setState(() {
                                    homeScreenController
                                        .updateFontSize(newSize);
                                  });
                                }
                              },
                              items: [
                                12.0,
                                16.0,
                                20.0,
                                24.0,
                                28.0,
                                32.0
                              ].map<DropdownMenuItem<double>>((double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      '$value',
                                      style: TextStyle(fontSize: value),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 55,
                            width: Get.width * .3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                changeColor(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    homeScreenController.textData["color"]![0],
                              ),
                              child: const Text(""),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        width: Get.width * .5,
                        child: ElevatedButton(
                          onPressed: () {
                            homeScreenController.textEditingController.clear();
                            homeScreenController.focusNode.requestFocus();
                          },
                          child: const Text("ADD TEXT"),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }

  void changeColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: homeScreenController.textData["color"]![0],
              onColorChanged: (Color color) {
                homeScreenController.textData["color"]![0] = color;
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  homeScreenController
                      .updateColor(homeScreenController.textData["color"]![0]);
                });
                Navigator.of(context).pop();
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
  }
}
