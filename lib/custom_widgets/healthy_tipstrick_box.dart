import 'package:flutter/material.dart';
import 'package:instascan/constants/constant.dart';
class HealthyTipsTrickBox extends StatefulWidget {
  const HealthyTipsTrickBox({super.key});

  @override
  State<HealthyTipsTrickBox> createState() => _HealthyTipsTrickBoxState();
}

class _HealthyTipsTrickBoxState extends State<HealthyTipsTrickBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 230,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF7EC9D4), width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 20, // Number of items
          itemBuilder: (context, index) {
            return Container(
              color: Color(0xFFFFECEC),
              child: ListTile(
                dense: true,
                leading: Icon(Icons.health_and_safety_outlined , color: Colors.pink,),
                title: Text(tips[index],style: TextStyle(fontFamily: 'Dongle', fontSize: 20),),
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) {  return SizedBox(height: 10); },
        ),
      ),
    );
  }
}
