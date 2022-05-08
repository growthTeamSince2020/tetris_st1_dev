import 'package:flutter/material.dart';

class SubBlock {
  late int x;
  late int y;
  late Color color;

  SubBlock(this.x, this.y, [Color color = Colors.transparent]) {
    this.color = color;
  }
}
