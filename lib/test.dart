// // ignore_for_file: prefer_const_constructors

// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   File? pickedFile;
  
//   Future<void> selectFilase() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) return;
//     setState(() {
//       pickedFile = File(result.files.single.path!);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               pickedFile != null
//                   ? Image.file(pickedFile!)
//                   : Placeholder(
//                       fallbackHeight: 200,
//                       fallbackWidth: double.infinity,
//                     ),
//               ElevatedButton(onPressed: selectFile, child: Text('Select File')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
