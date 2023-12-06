import 'package:flutter/material.dart';

class CategoryModel {
  IconData icon;
  String title;
  String subtitle;
  Color color;

  CategoryModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

final List<CategoryModel> category = [
  CategoryModel(
    icon: Icons.sports_baseball,
    title: "Sports",
    subtitle: "12 Latest News",
    color: const Color(0xFFE71D35),
  ),
  CategoryModel(
    icon: Icons.add,
    title: "Health",
    subtitle: "9 Latest News",
    color: const Color(0xFF2EC5B6),
  ),
  CategoryModel(
    icon: Icons.music_note,
    title: "Music",
    subtitle: "16 Latest News",
    color: const Color(0xFFFF9F1C),
  ),
  CategoryModel(
    icon: Icons.plus_one,
    title: "Add New",
    subtitle: "",
    color: Colors.black,
  ),
];
