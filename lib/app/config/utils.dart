import 'package:enviostoresms/app/config/constant.dart';
import 'package:enviostoresms/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data_source/prefered_controller.dart';
import 'string_app.dart';

class Utils {
  static var prefs = Get.put(PreferedController());

  static Color pokemonColor(String _type) {
    String color = '0xff000000';
    switch (_type) {
      case "normal":
        color = '0xff808080'; //gray
        break;
      case "fighting":
        color = '0xff8b0000'; // Dark Red
        break;
      case "flying":
        color = '0xffD3D3D3'; //White
        break;
      case "poison":
        color = '0xff800080'; //Purple
        break;
      case "ground":
        color = '0xfff5f5dc'; //Beige
        break;
      case "rock":
        color = '0xff654321'; //Brown
        break;
      case "bug":
        color = '0xff7fff00'; //Chartreuse
        break;
      case "ghost":
        color = '0xff301934'; // Dark Purple
        break;
      case "steel":
        color = '0xffa9a9a9'; // Dark Grey
        break;
      case "fire":
        color = '0xffff0000'; // red
        break;
      case "water":
        color = '0xff0000ff'; // blue
        break;
      case "grass":
        color = '0xff008000'; // Green
        break;
      case "electric":
        color = '0xffffff00'; // yellow
        break;
      case "psychic":
        color = '0xffff00ff'; // Magenta
        break;
      case "ice":
        color = '0xff00ffff'; // Cyan
        break;
      case "dragon":
        color = '0xff000080'; // Navy
        break;
      case "dark":
        color = '0xff000000'; // black
        break;
      case "fairy":
        color = '0xfffadadd'; // Pale Pink
        break;
      case "unknown":
        color = '0xffadd8e6'; // light blue
        break;
      case "shadow":
        color = '0xffa9a9a9'; // dark gray
        break;

      default:
        color = '0xff000000'; //
    }
    Color statusColor = Color(int.parse(color));

    return statusColor;
  }
}
