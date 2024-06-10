import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/provider/user_provider.dart';
import 'package:suitmedia_test/utils/constants.dart';

import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  final String currentUser;

  const SecondScreen({super.key, required this.currentUser});

  void _goToThirdScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ThirdScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBar(context, "Second Screen"),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
                Text(currentUser,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            Center(
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Text(userProvider.selectedUserName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ));
                },
              ),
            ),
            ElevatedButton(
              style: elevatedButtonStyle,
              onPressed: () => _goToThirdScreen(context),
              child: Text(
                'Choose a User',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
