
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaterButton extends StatelessWidget {
  final int amount;
  final String text;

  WaterButton({required this.amount, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0x4C4B39EF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Icon(
            Icons.local_drink,
            color: Colors.white,
            size: 32.0,
          ),
          SizedBox(height: 8.0),
          Text(
            '$amount mL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
