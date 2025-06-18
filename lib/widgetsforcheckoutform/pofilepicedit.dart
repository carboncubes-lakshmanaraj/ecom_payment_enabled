import 'package:flutter/material.dart';

class ProfilePictureWithEdit extends StatelessWidget {
  final String assetPath;
  final VoidCallback onEdit;

  const ProfilePictureWithEdit({
    super.key,
    required this.assetPath,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 100.0;

    return Stack(
      children: [
        // Circular Profile Picture
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(assetPath),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Circular Edit Icon Button
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: size * 0.3,
            height: size * 0.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit, color: Colors.white, size: 16),
              onPressed: onEdit,
            ),
          ),
        ),
      ],
    );
  }
}
