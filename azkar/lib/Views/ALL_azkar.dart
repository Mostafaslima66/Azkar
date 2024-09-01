import 'package:azkar/Models/Azkarcategory_model.dart';
import 'package:azkar/Views/AfterPrayAzkar_view.dart';
import 'package:azkar/Views/EveningAzkar_view.dart';
import 'package:azkar/Views/ExitAzkar_view.dart';
import 'package:azkar/Views/FoodAzkar_view.dart';
import 'package:azkar/Views/MorningAzkar_view.dart';
import 'package:azkar/Views/TravelAzkar_view.dart';
import 'package:azkar/Widgets/Azkar_widget.dart';
import 'package:flutter/material.dart';

class AllAzkarView extends StatelessWidget {
  AllAzkarView({super.key});
  static String id = 'All_Azkar';
  final List<Azkarcategory_Model> Azkar_Model = [
   const Azkarcategory_Model(
        pageName: MorningAzkarView(),
        name: 'اذكار الصباح',
        icon: 'assets/images/sun.png'),
  const  Azkarcategory_Model(
        pageName: EveningAzkarView(),
        name: 'اذكارالمساء',
        icon: 'assets/images/moon.png'),
   const Azkarcategory_Model(
        pageName: ExitAzkarView(),
        name: ' اذكار الخروج ',
        icon: 'assets/images/door.png'),
   const Azkarcategory_Model(
        pageName: AfterprayAzkarView(),
        name: ' اذكار بعد الصلاة',
        icon: 'assets/images/pray3.png'),
   const Azkarcategory_Model(
        pageName: FoodAzkarView(),
        name: 'اذكار الطعام',
        icon: 'assets/images/food.png'),
   const Azkarcategory_Model(
        pageName: TravelAzkarView(),
        name: 'دعاء السفر',
        icon: 'assets/images/airplane.png'),
  ];
  @override
  Widget build(BuildContext context) {
   
    return Container(
      height: double.infinity,
        width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/image-from-rawpixel-id-8306864-jpeg.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color(0xffefede6),
          title: const Text(
            'الاذكار',
            style: TextStyle(
                color: Color(0xffbd7e4a),
                fontFamily: 'Cairo',
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffbd7e4a),
                size: 30,
              )),
        ),
        body: ListView.builder(
            itemCount: Azkar_Model.length,
            itemBuilder: (context, index) {
              return Azkarwidget(Azkar_Model: Azkar_Model[index]);
            })

      ),
    );
  }
}
