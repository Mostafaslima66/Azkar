import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.name, required this.photo,required this.ontap});
  final String name;
  final String photo;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: 
          ontap,
        
        child: Container(
          height: 120,
          width: 130,
          decoration: BoxDecoration(
              color:const Color(0xffefede6),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                photo,
                scale: 11,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                    color: Color(0xffbd7e4a),
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
