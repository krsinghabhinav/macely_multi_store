// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LandingScreen extends StatefulWidget {
//   const LandingScreen({super.key});

//   @override
//   State<LandingScreen> createState() => _LandingScreenState();
// }

// class _LandingScreenState extends State<LandingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final CollectionReference _vendorStream =
//         FirebaseFirestore.instance.collection('vendors');

//     return Scaffold(
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
//         builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           // Handle errors
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Something went wrong',
//                 style: TextStyle(fontSize: 30),
//               ),
//             );
//           }

//           // Show loading spinner while waiting for data
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           // Check if the document exists
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(
//               child: Text(
//                 'No vendor data available',
//                 style: TextStyle(fontSize: 20),
//               ),
//             );
//           }

//           // Get the data from the snapshot
//           dynamic data = snapshot.data!.data() as Map<String, dynamic>;

//           // Display the data directly
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   // radius: 60,
//                   // foregroundImage,
//                 ),
//                 Text(
//                   'Business Name: ${data['bussinessName'] ?? 'N/A'}',
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text('Email: ${data['email'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text('Phone Number: ${data['phoneNumber'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text('City: ${data['cityValue'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text('Country: ${data['countryValue'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text('State: ${data['stateValue'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text('Tax Number: ${data['taxNumber'] ?? 'N/A'}',
//                     style: TextStyle(fontSize: 18)),
//                 SizedBox(height: 10),
//                 Text(
//                   'Approved: ${data['approved'] == true ? 'Yes' : 'No'}',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color:
//                           data['approved'] == true ? Colors.green : Colors.red),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
