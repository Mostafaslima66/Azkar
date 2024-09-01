import 'package:azkar/Views/ALL_azkar.dart';
import 'package:azkar/Views/Sebha_view.dart';
import 'package:azkar/Widgets/Custom_container.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'Home_View';

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/image-from-rawpixel-id-8306864-jpeg.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'حصن المسلم',
              style: TextStyle(
                  color: Color(0xffbd7e4a),
                  fontFamily: 'Cairo',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: isPortrait ? 30 : screenWidth * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                  name: 'الاذكار',
                  photo: 'assets/images/quraan.png',
                  ontap: () {
                    Navigator.pushNamed(context, AllAzkarView.id);
                  },
                ),
                CustomContainer(name: 'التسبيح', photo: 'assets/images/sebha (2).jpg', ontap: (){
                   Navigator.pushNamed(context, SebhaView.id);
                })
               
                
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
