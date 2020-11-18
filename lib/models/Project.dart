import 'package:flutter/material.dart';

class Project {
  final String id, image, title, description, collaborators;
  final int percentage;
  final Color color;
  Project({
    this.id,
    this.image,
    this.title,
    this.description,
    this.collaborators,
    this.percentage,
    this.color,
  });
}

List<Project> projects = [
  Project(
      id: 'P01',
      title: "Project 01234567 89012345",
      description: dummyText,
      image: "assets/images/icon_1.png",
      percentage: 30,
      collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
      color: Color(0xFF3D82AE)),
  Project(
      id: 'P02',
      title: "Project 02",
      description: dummyText,
      image: "assets/images/icon_2.png",
      percentage: 50,
      collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
      color: Color(0xFFD3A984)),
  Project(
      id: 'P03',
      title: "Project 03",
      description: dummyText,
      image: "assets/images/icon_3.png",
      percentage: 60,
      collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
      color: Color(0xFF989493)),
  Project(
      id: 'P04',
      title: "Project 04",
      description: dummyText,
      image: "assets/images/icon_4.png",
      percentage: 70,
      collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
      color: Color(0xFFE6B398)),
  Project(
      id: 'P05',
      title: "Project 05",
      description: dummyText,
      image: "assets/images/icon_5.png",
      percentage: 80,
      collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
      color: Color(0xFFFB7883)),
  Project(
    id: 'P06',
    title: "Project 06",
    description: dummyText,
    image: "assets/images/icon_6.png",
    percentage: 10,
    collaborators: "Andy Chung Jack Vui, Tsen Jing Sheng, Khoo Teck Wei, Voo Kee Yuen",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
