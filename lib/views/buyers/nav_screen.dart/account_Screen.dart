import 'package:bestproviderproject/models/profile_account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final CollectionReference buyerUsers =
      FirebaseFirestore.instance.collection('buyers');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _showEditProfileDialog(
      BuildContext context, String? currentFullName, String? currentEmail) {
    TextEditingController fullNameController =
        TextEditingController(text: currentFullName);
    TextEditingController emailController =
        TextEditingController(text: currentEmail);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Container(
            width: double
                .infinity, // Set the width to 90% of screen width, leaving 5% margin on both sides
            height: 130, // Set the height as desired
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button action
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Update the user's profile in Firestore
                await _firestore
                    .collection('buyers')
                    .doc(_auth.currentUser!.uid)
                    .update({
                  'email': emailController.text,
                  'fullName': fullNameController.text,
                });

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to check for user data in Firestore directly
    return FutureBuilder<DocumentSnapshot>(
      future: buyerUsers.doc(_auth.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong: ${snapshot.error}"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Show loading indicator
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text("User not logged in"));
        }

        var buyersUsers = ProfileAccountModel.fromJson(
            snapshot.data!.data() as Map<String, dynamic>);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            automaticallyImplyLeading: false,
            elevation: 5,
            title: const Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  Icons.star,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundColor: Colors.red,
                    backgroundImage: buyersUsers.profileImage != null &&
                            buyersUsers.profileImage!.isNotEmpty
                        ? NetworkImage(buyersUsers.profileImage!)
                        : null,
                    child: buyersUsers.profileImage == null ||
                            buyersUsers.profileImage!.isEmpty
                        ? Icon(Icons.person, size: 60, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Text(
                  buyersUsers.fullName ?? 'User Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  buyersUsers.email ?? 'user@example.com',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    _showEditProfileDialog(
                      context,
                      buyersUsers.fullName,
                      buyersUsers.email,
                    ); // Show the edit profile dialog
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Divider(thickness: 2),
                ),
                ListTile(
                  leading: Icon(Icons.settings,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.phone,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Phone Number',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    buyersUsers.phoneNumber ?? 'Phone number not available',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Cart',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart_checkout,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Orders',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout,
                      size: MediaQuery.of(context).size.width * 0.06),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Color.fromARGB(255, 78, 76, 76),
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    await _auth.signOut(); // Sign out the user
                    Navigator.of(context).pushReplacementNamed(
                        '/login'); // Navigate to login screen
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
