import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;

  const Avatar({this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: avatarUrl == null
            ? CircleAvatar(
                radius: 100.0,
                child: Icon(Icons.photo_camera),
              )
            : CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(avatarUrl!),
              ),
      ),
    );
  }
}
