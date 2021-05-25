import 'package:flutter/material.dart';

class Project {
  String name;
  int members;
  int gradientColorIndex;

  Project(
      {required this.name,
      required this.members,
      required this.gradientColorIndex});
}

List<Project> projects = [
  Project(name: "수원대학교 모바일운영체제", members: 3, gradientColorIndex: 0),
  Project(name: "수원대학교 C언어 ", members: 4, gradientColorIndex: 1),
  Project(name: "수원대학교 자바", members: 2, gradientColorIndex: 2),
  Project(name: "수원대학교 파이썬", members: 5, gradientColorIndex: 3),
  Project(name: "수원대학교 웹", members: 6, gradientColorIndex: 4),
];

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
  static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
  static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
  static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
  static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
