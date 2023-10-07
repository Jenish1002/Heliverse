// lib/user_card.dart
import 'package:flutter/material.dart';
import 'user.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.firstName} ${user.lastName}'),
            Text('Email: ${user.email}'),
            Text('Gender: ${user.gender}'),
            Text('Domain: ${user.domain}'),
            Text('Available: ${user.available ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
