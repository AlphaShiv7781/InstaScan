import 'dart:io';

import 'package:flutter/material.dart';
class ResultImageWidget extends StatelessWidget {
  const ResultImageWidget({super.key, this.imageFile, required this.imageType});
  final File? imageFile;
  final String imageType;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 2,
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Image.file(imageFile!,),
            SizedBox(
              height: 10,
            ),
            Text(imageType),
          ],
        ),
      ),
    );
  }
}
