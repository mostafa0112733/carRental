import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowCarRentals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            Text('Cairo, Nasr city', style: TextStyle(color: Colors.black)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'Item 1',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle Drawer Item 1 tap
                  Navigator.pop(context);
                },
              ),
              // Add more ListTile widgets for additional items in the drawer
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 85, // Set the height for the button row

            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/mercedes.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/hundayi.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/byd.png'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
                CarLogoButton(imagePath: 'assets/images/carslogo/bmw.jpg'),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('carRentals')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child:
                          CircularProgressIndicator()); // Display a loading indicator
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No car rentals available.'),
                  );
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns in each row
                    childAspectRatio: 0.7, // Square ratio for each item
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var carData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    String brand = carData['brand'] ?? 'N/A';
                    double costPerDay = carData['costPerDay'] ?? 0.0;
                    String insurance = carData['insurance'] ?? 'N/A';
                    Map<String, dynamic> address = carData['address'] ?? {};
                    String city = address['city'] ?? 'N/A';
                    String region = address['region'] ?? 'N/A';
                    String imageUrl = carData['image'] ?? ''; // Image URL

                    return Card(
                      elevation: 3.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageUrl),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' $brand',
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  'Cost Per Day: \$${costPerDay.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Insurance: $insurance',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'City: $city',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Region: $region',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CarLogoButton extends StatelessWidget {
  final String imagePath;

  CarLogoButton({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Set the desired width for each logo button
      height: 100, // Set the desired height for each logo button
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the button background color
        ),
        onPressed: () {
          // Handle button press, if needed
        },
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // Ensure the logo fits within the button
        ),
      ),
    );
  }
}
