import 'package:flutter/material.dart';

class ShimmerPostTile extends StatelessWidget {
  const ShimmerPostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder for profile and name
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 150,
                height: 20,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),

        // Placeholder for post image
        Container(
          width: double.infinity,
          height: 400,
          color: Colors.grey.shade300,
        ),

        // Placeholder for likes, comments, and publication time
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                color: Colors.grey.shade300,
              ),
              const SizedBox(width: 10),
              Container(
                width: 50,
                height: 20,
                color: Colors.grey.shade300,
              ),
              const Spacer(),
              Container(
                width: 100,
                height: 20,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
