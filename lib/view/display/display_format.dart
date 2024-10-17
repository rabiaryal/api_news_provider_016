import 'package:api_provider_016/config/appurl.dart';
import 'package:api_provider_016/view/display/display_box.dart';
import 'package:flutter/material.dart';
import 'package:api_provider_016/view/home/home_screen.dart'; // Import the HomeScreen

class DisplayMainUnit extends StatefulWidget {
  const DisplayMainUnit({super.key});

  @override
  State<DisplayMainUnit> createState() => _DisplayMainUnitState();
}

class _DisplayMainUnitState extends State<DisplayMainUnit> {
  // Define a function to navigate and pass the URL for each category
  void functionToCallApi(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(apiUrl: url), // Pass the URL to the HomeScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DisplayBox(
                  onPressed: () {
                    functionToCallApi(AppUrl.sportsUrl); // Call API for Sports
                  },
                  boxTitle: 'Sports',
                  boxIcon: Image.asset('images/sports.png'),
                ),
                DisplayBox(
                  onPressed: () {
                    functionToCallApi(AppUrl.techUrl); // Call API for Tech
                  },
                  boxTitle: 'Tech',
                  boxIcon: Image.asset('images/techimage.png'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DisplayBox(
                  onPressed: () {
                    functionToCallApi(AppUrl.polticsUrl); // Call API for Politics
                  },
                  boxTitle: 'Politics',
                  boxIcon: Image.asset('images/poltics-2.png'),
                ),
                DisplayBox(
                  onPressed: () {
                    functionToCallApi(AppUrl.businessUrl); // Call API for Business
                  },
                  boxTitle: 'Business',
                  boxIcon: Image.asset('images/business.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DisplayBox(
                  onPressed: () {
                    functionToCallApi(AppUrl.entertainmentUrl); // Call API for Entertainment
                  },
                  boxTitle: 'Entertainment',
                  boxIcon: Image.asset('images/entertainment.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
