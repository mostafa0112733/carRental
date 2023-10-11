// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gocar/showscar.dart';



class UploadCarForRent extends StatefulWidget {
  @override
  _UploadCarForRentState createState() => _UploadCarForRentState();
}

class _UploadCarForRentState extends State<UploadCarForRent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _costPerDayController = TextEditingController();
  final TextEditingController _insuranceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  File? pickedFile;
  
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = File(result.files.single.path!);
    });
  }

  
  Future<void> SelectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = File(result.files.single.path!);
    });
  }

  void _uploadCarForRent() async {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      Map<String, dynamic> carData = {
        'brand': _brandController.text,
        'costPerDay': double.parse(_costPerDayController.text),
        'insurance': _insuranceController.text,
        'address': {
          'city': _cityController.text,
          'region': _regionController.text,
        },
      };

      if (pickedFile != null) {
        final storage = FirebaseStorage.instance;
        final Reference storageReference =
            storage.ref().child('car_images/${pickedFile!.path}');
        await storageReference.putFile(File(pickedFile!.path));
        final imageUrl = await storageReference.getDownloadURL();
        carData['image'] = imageUrl;
      }

      try {
        await firestore.collection('carRentals').add(carData);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => ShowCarRentals()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error uploading car rental: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Car for Rent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: selectFile,
                child: Text('Select Image'),
              ),
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the brand';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _costPerDayController,
                decoration: InputDecoration(labelText: 'Cost Per Day'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cost per day';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _insuranceController,
                decoration: InputDecoration(labelText: 'Insurance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the insurance details';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _regionController,
                decoration: InputDecoration(labelText: 'Region'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the region';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _uploadCarForRent,
                child: Text('Upload Car for Rent'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
