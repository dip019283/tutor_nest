import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(
          Icons.person,
          size: 40.0,
          color: Colors.blue,
        ),
        title: Text(
          'Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text('Admin Portal'),
      ),
    );
  }
}
