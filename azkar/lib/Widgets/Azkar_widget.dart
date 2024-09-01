import 'package:azkar/Models/Azkarcategory_model.dart';
import 'package:flutter/material.dart';

class Azkarwidget extends StatelessWidget {
  const Azkarwidget({super.key, required this.Azkar_Model});
  final Azkarcategory_Model Azkar_Model;
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Azkar_Model.pageName;
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffa55e47),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        width: double.infinity,
        height: isPortrait ? 100 : 120,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                Azkar_Model.name,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20,
              ),
              const VerticalDivider(
                indent: 15,
                endIndent: 15,
                color: Colors.white,
                width: 0.5,
                thickness: 2,
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(125),
                    border: Border.all(width: 3, color: Colors.white),
                    color: Colors.white),
                child: Image.asset(
                  Azkar_Model.icon,
                  height: MediaQuery.of(context).size.height * .065,
                  alignment: Alignment.centerRight,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
