import 'package:flutter/material.dart';

/// Widget for History Card
class HistoryCard extends StatelessWidget {
  final int recordCount;
  final VoidCallback onTap;

  HistoryCard({required this.recordCount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("History",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.history, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    "Go to history",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
