import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  var textData = {
    "font_size": [16.0],
    "color": [Colors.black],
    "font_family": [],
    "font_weight": [FontWeight.normal],
  };
  FocusNode focusNode = FocusNode();
  var textStack = <Map<String, List<dynamic>>>[];
  var redoStack = <Map<String, List<dynamic>>>[];
  bool isLoading = false;

  String selectedValue = 'Normal';

  void updateFontSize(double newSize) {
    Map<String, dynamic> newData = {
      "font_size": [newSize],
      "color": [textData["color"]![0]],
      "font_family": [],
      "font_weight": [textData["font_weight"]![0]],
    };
    textData = newData.cast<String, List<dynamic>>();
    updateStack();
  }

  void updateColor(Color newColor) {
    Map<String, dynamic> newData = {
      "font_size": [textData["font_size"]![0]],
      "color": [newColor],
      "font_family": [],
      "font_weight": [textData["font_weight"]![0]],
    };
    textData = newData.cast<String, List<dynamic>>();
    updateStack();
  }

  void updateFontWeight(FontWeight newFontWeight) {
    Map<String, dynamic> newData = {
      "font_size": [textData["font_size"]![0]],
      "color": [textData["color"]![0]],
      "font_family": [],
      "font_weight": [newFontWeight],
    };
    textData = newData.cast<String, List<dynamic>>();
    updateStack();
  }

  void updateStack() {
    textStack.add(Map<String, List<dynamic>>.from(textData));

    redoStack.clear();
    update();
  }

  void undo() {
    try {
      if (textStack.length > 1) {
        redoStack.add(Map<String, List<dynamic>>.from(textData));
        textStack.removeLast();
        textData = Map<String, List<dynamic>>.from(textStack.last);
        if ('${textData["font_weight"]![0]}' == 'FontWeight.w400') {
          selectedValue = 'Normal';
        } else {
          selectedValue = 'Bold';
        }
        update();
      } else {
        print('nothing to undo');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void redo() {
    try {
      if (redoStack.isNotEmpty) {
        textStack.add(Map<String, List<dynamic>>.from(textData));
        textData = Map<String, List<dynamic>>.from(redoStack.removeLast());

        if ('${textData["font_weight"]![0]}' == 'FontWeight.w400') {
          selectedValue = 'Normal';
        } else {
          selectedValue = 'Bold';
        }
        update();
      } else {
        print('nothing to redo');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
