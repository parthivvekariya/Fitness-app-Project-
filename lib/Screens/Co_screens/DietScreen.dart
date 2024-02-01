import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';
import 'meals.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({Key? key}) : super(key: key);

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final List<ItemModel> dietPlans = [
    ItemModel(
      imageUrl:
      "https://roasting-conflict.000webhostapp.com/images/wellindia/diet/th.jpeg",
      title: "Mood Booster - 7 Day Diet Plan",
      about: 'Improves overall health · Supports gut health · Boosts immunity',
    ),
    ItemModel(
      imageUrl:
      "https://roasting-conflict.000webhostapp.com/images/wellindia/diet/th%20(1).jpeg",
      title: "Gluten Free Anti-Inflammatory Plan",
      about: 'Improves digestion and reduce inflammation, Improved digestion and may clear up skin, Increased energy and improve sleep',
    ),
    ItemModel(
      imageUrl:
      "https://roasting-conflict.000webhostapp.com/images/wellindia/diet/th%20(2).jpeg",
      title: "Weight Loss Diet Plan",
      about: 'Promotes weight loss · Lowers risks of heart disease and diabetes · Boosts your immune system',
    ),
    ItemModel(
      imageUrl: "https://roasting-conflict.000webhostapp.com/images/wellindia/diet/th%20(3).jpeg",
      title: "Vegetarian Low Calorie Meal Plan",
      about: 'May promote weight loss · Promotes vital health · Improves immunity',
    ),
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
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                            "https://roasting-conflict.000webhostapp.com/images/wellindia/diet.jpeg"),
                      ),
                    ],
                  ),
                ),
              ),
              expandedHeight: 340,
            )
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Container(
                  child: Text(
                    "A balanced diet is crucial for maintaining optimal health, providing the body with essential nutrients, vitamins, and minerals. It typically includes a variety of food groups such as fruits, vegetables, whole grains, lean proteins, and healthy fats. Adhering to a well-rounded diet supports overall well-being, aids in weight management, and lowers the risk of chronic diseases.",
                  ),
                ),
                SizedBox(height: 10,),
                Container(

                  child: Card(
                    child:GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => meal(),),);

                      },
                      child: ListTile(
                        leading: Text("Daily Meal",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkblue,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                Text(
                  'Suggested Diet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 500000,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dietPlans.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        title: ListTile(
                          leading: Image.network(
                            dietPlans[index].imageUrl,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(dietPlans[index].title),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dietPlans[index].about,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
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

class ItemModel {
  final String title;
  final String imageUrl;
  final String about;

  ItemModel({
    required this.title,
    required this.imageUrl,
    required this.about,
  });
}
