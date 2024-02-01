import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// final List<String> meals = [
//   'Breakfast: Whole grain cereal or oatmeal with fruits and nuts',
//
//   'Mid-Morning Snack: Apple slices with nut butter',
//
//   'Lunch: Grilled chicken or tofu salad with mixed vegetables',
//
//   'Afternoon Snack: Carrot and cucumber sticks with hummus',
//
//   'Dinner: Baked salmon or a lentil stew',
//
//   'Evening Snack: A piece of fruit (e.g., banana or pear)',
// ];
//


class meal extends StatefulWidget {
  const meal({super.key});

  @override
  State<meal> createState() => _mealState();
}

class _mealState extends State<meal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Plan'),
      ),
      body: DietPlan(),
    );
  }
}


class DietPlan extends StatelessWidget {
  // Sample diet plan data
  final List<String> meals = [
    'Breakfast: Whole grain cereal or oatmeal with fruits and nuts',
    'Mid-Morning Snack: Apple slices with nut butter',
    'Lunch: Grilled chicken or tofu salad with mixed vegetables',
    'Afternoon Snack: Carrot and cucumber sticks with hummus',
    'Dinner: Baked salmon or a lentil stew',
    'Evening Snack: A piece of fruit (e.g., banana or pear)',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(meals[index]),
          ),
        );
      },
    );
  }
}



