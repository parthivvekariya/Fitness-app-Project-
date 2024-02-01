import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellindia/Screens/setting.dart';
import '../colors/SemiCircularStepCounter.dart';
import '../colors/WaterButton.dart';
import '../colors/app_colors.dart';
import 'Co_screens/DietScreen.dart';
import 'Co_screens/Meditation.dart';
import 'Co_screens/WorkoutsScreen.dart';
import 'Co_screens/Yoga.dart';


String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  final int totalSteps = 10000;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String  _steps = '?';
  DateTime _currentDate = DateTime.now();
  int _stepsToday = 0;
  double waterIntake = 0.0; // in liters
  int _currentWaterLevel = 0;
  final int _dayTarget = 4000;
  double _completionPercent = 0.0;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  
// Add these variables to your widget class to store the data.
  double stepLength = 0.76; // Assume an average step length in meters
  double caloriesPerStep = 0.04; // Assume a calorie burn rate per step

  List<double> waterIntakeData = [];
  final List<ItemModel> itemModel = [
    ItemModel(imageUrl: "https://roasting-conflict.000webhostapp.com/images/wellindia/meditation.jpg", title: "Meditation"),
    ItemModel(imageUrl: "https://roasting-conflict.000webhostapp.com/images/wellindia/yoga.jpg", title: "Yoga"),
    ItemModel(imageUrl: "https://roasting-conflict.000webhostapp.com/images/wellindia/man-lifting.jpg", title: "Workouts"),
    ItemModel(imageUrl: "https://roasting-conflict.000webhostapp.com/images/wellindia/diet.jpeg", title: "Diet"),
  ];

  // Function to calculate distance based on steps
  double calculateDistance(int steps) {
    return steps * stepLength / 1000.0; // Convert distance to kilometers
  }
// Function to calculate calories based on steps
  int calculateCalories(int steps) {
    return (steps * caloriesPerStep).round();
  }

  @override
  void initState() {
    super.initState();
    _completionPercent = _currentWaterLevel / _dayTarget;
    initPlatformState();

    // Load step count from persistent storage
    loadStepCount();

    // Set up the step count stream
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    // Initialize notifications
    initializeNotifications();

    // Schedule notification after one hour
    scheduleNotification();
    
  }

  //Notification
  void initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  Future<void> scheduleNotification() async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'your_channel_id', // Change this value for different channels
          'Your Channel Name',
          importance: Importance.max,
          priority: Priority.high,
        );

        const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

        // Schedule notification after one hour
        var tz;
        await flutterLocalNotificationsPlugin.zonedSchedule(
          1, // Notification ID
          'Reminder',
          'Don\'t forget to stay hydrated and take a break!',
          tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
          platformChannelSpecifics,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  // Future<void> scheduleNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     'your_channel_id', // Change this value for different channels
  //     'Your Channel Name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //   // Schedule notification after one hour
  //   var tz;
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     1, // Notification ID
  //     'Reminder',
  //     'Don\'t forget to stay hydrated and take a break!',
  //     tz.TZDateTime.now(tz.local).add(const Duration(hours: 1)),
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //     UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }
  
  // Load step count from persistent storage
  void loadStepCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _stepsToday = prefs.getInt('stepCount') ?? 0;
    });
  }

  // Save step count to persistent storage
  void saveStepCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('stepCount', _stepsToday);
  }


  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
      // Update steps for today
      _stepsToday = event.steps;
      // Save step count to persistent storage
      saveStepCount();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void incrementWaterIntake(double amount) {
    setState(() {
      waterIntake += amount;
      waterIntakeData.add(waterIntake);
    });
  }


  void _addWater(int amount) {
    setState(() {
      _currentWaterLevel += amount;
      _completionPercent = _currentWaterLevel / _dayTarget;
    });
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                snap: true,
                pinned: false,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Color(0x4C4B39EF),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF4B39EF),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(44),
                              child: Image.asset(
                                'assets/images/user.png',
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                  child: Text(
                                    'Welcome',
                                    style: Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Color(0xFF14181B),
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Health is Wealth',
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Color(0xFF14181B),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Color(0xFF57636C),
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                expandedHeight: 230,
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              color: AppColors.darkblue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),   // Adjust the radius as needed
                topRight: Radius.circular(15.0),  // Adjust the radius as needed
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Scaffold(
              backgroundColor: AppColors.darkblue,
              body: SingleChildScrollView(
                child: Column(
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
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: itemModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${itemModel[index].title}'),
                                ),
                              );

                              if(itemModel[index].title == "Meditation")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MeditationScreen(),),);
                              }
                              else if (itemModel[index].title == "Yoga")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => YogaScreen(),),);
                              }
                              else if (itemModel[index].title == "Workouts")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutsScreen(),),);
                              }
                              else if (itemModel[index].title == "Diet")
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DietScreen(),),);
                              }
                              else
                              {
                               print(' chalja');
                              }
                            },
                            child: Card(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                  index == 0 ? 16 : 0,
                                  12,
                                  12,
                                  12,
                                ),
                                child: Container(
                                  width: 160,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.transparent,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.network(
                                            itemModel[index].imageUrl,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                          child: Text(
                                            itemModel[index].title,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    // step count   Walking record
                            Container(
                              height: 430,
                              width: double.infinity,
                              child: Card(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 10,),
                                              Text(
                                                "Today's Walking record",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),

                                          Column(
                                            children: [
                                              SizedBox(height: 20),
                                              CustomPaint(
                                                painter: SemiCircularStepCounter(
                                                  steps: _stepsToday,
                                                  totalSteps: totalSteps,
                                                ),
                                                child: Container(
                                                  width: 200,
                                                  height: 200,
                                                  child: Center(
                                                    child: Text(
                                                      '$_stepsToday',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Slow walking',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Brisk walking',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              LinearProgressIndicator(
                                                value: _stepsToday / totalSteps,
                                                backgroundColor: Colors.red,
                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Distance ${calculateDistance(_stepsToday).toStringAsFixed(2)} km',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Calories ${calculateCalories(_stepsToday)} kcal',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 6),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    // Whater count

                    Container(

                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10,),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10,),
                                Text(
                                  "Water Tracker",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(
                                ' $_currentWaterLevel mL',style: TextStyle( fontSize: 30,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Daily target: $_dayTarget mL',
                            ),
                            SizedBox(height: 16.0),
                            LinearProgressIndicator(
                              value: _completionPercent,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0x4C4B39EF),),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _addWater(150);
                                  },
                                  child: WaterButton(
                                    amount: 150,
                                    text: 'Add 150 mL',
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                GestureDetector(
                                  onTap: () {
                                    _addWater(350);
                                  },
                                  child: WaterButton(
                                    amount: 350,
                                    text: 'Add 350 mL',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        )
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// item_model.dart
class ItemModel {
  final String title;
  final String imageUrl;

  ItemModel({required this.title, required this.imageUrl});
}
