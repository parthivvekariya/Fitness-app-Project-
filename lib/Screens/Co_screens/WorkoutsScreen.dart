import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  // Added ExerciseModel and sample data
  final List<ExerciseModel> exercises = [
    ExerciseModel(
      title: 'Push ups',
      subtitle: '25 reps, 4 sets',
      imagePath: 'assets/images/Workouts/pushups.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Crunches',
      subtitle: '30 reps, 2 sets',
      imagePath: 'assets/images/Workouts/crunches.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Planks',
      subtitle: '60 secs, 2 sets',
      imagePath: 'assets/images/Workouts/planks.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Climbers',
      subtitle: '25 reps, 4 sets',
      imagePath: 'assets/images/Workouts/climbers.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Squats',
      subtitle: '20 reps, 3 sets',
      imagePath: 'assets/images/Workouts/squats.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Side Planks',
      subtitle: '60 secs, 2 sets',
      imagePath: 'assets/images/Workouts/sideplanks.jpg',
      completionIcon: 'Icons.check',
    ),
    ExerciseModel(
      title: 'Sit ups',
      subtitle: '25 reps, 4 sets',
      imagePath: 'assets/images/Workouts/situps.jpg',
      completionIcon: 'Icons.check',
    ),
    // Add more exercises as needed
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              snap: true,
              pinned: true,
              floating: true,
              expandedHeight: 255,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                            "https://roasting-conflict.000webhostapp.com/images/wellindia/worko.jpg"),
                      )
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grayColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  child: Text(
                    "Engage in a diverse workout routine that combines cardiovascular exercises, strength training, and flexibility workouts to promote overall fitness. Consistency is key, so find activities you enjoy to make staying active a sustainable and enjoyable part of your lifestyle.",
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  'Your Workouts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Custom ListView for Exercises
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return ExerciseListItem(exercise: exercises[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseModel {
  final String title;
  final String subtitle;
  final String imagePath;
  final String completionIcon;

  ExerciseModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.completionIcon,
  });
}

class ExerciseListItem extends StatelessWidget {
  final ExerciseModel exercise;

  const ExerciseListItem({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.2,
            offset: Offset(0.3, 0.5),
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: ExactAssetImage(exercise.imagePath),
          radius: 25,
        ),
        title: Text(
          exercise.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          exercise.subtitle,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
