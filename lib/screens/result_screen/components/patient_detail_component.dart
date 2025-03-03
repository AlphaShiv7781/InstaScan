import 'package:flutter/material.dart';
class PatientDetailComponent extends StatelessWidget {
  const PatientDetailComponent({super.key, required this.name, required this.phoneNumber, required this.email, required this.age, required this.dob, required this.gender});
  final String name;
  final String phoneNumber;
  final String email;
  final String age;
  final String dob;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Name of Patient :'),
            Text(name),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient Contact Number :'),
            Text(phoneNumber),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Patient Email Id :'),
            Text(email),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Age of Patient :'),
            Text(age),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Date of Birth :'),
            Text(dob),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gender :'),
            Text(gender),
          ],
        ),
      ],
    );
  }
}
