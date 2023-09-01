import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriorityListTile extends StatelessWidget {
  final String title;

  const PriorityListTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDEE2E6), width: 2),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
