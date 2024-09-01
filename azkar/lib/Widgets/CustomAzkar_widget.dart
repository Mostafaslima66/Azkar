import 'package:flutter/material.dart';

class CustomAzkar extends StatelessWidget {
  const CustomAzkar({super.key, required this.thedata,  });
final String thedata;
  @override
  Widget build(BuildContext context) {
    // bool isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 5),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Container(
        
          decoration: BoxDecoration(color: Color(0xffA55D46),borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(thedata,
                strutStyle: StrutStyle(leading:2 ,),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'Cairo',textBaseline: TextBaseline.alphabetic),),
              ),
            
            ],
          ),
        )],
      )
    );
  }
}
