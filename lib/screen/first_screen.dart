import 'package:flutter/material.dart';
import 'package:suitmedia_test/utils/constants.dart';
import 'package:suitmedia_test/screen/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _palindromeController = TextEditingController();

  bool isPalindrome(String text) {
    String cleanedText = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    String reversedText = cleanedText.split('').reversed.join('');
    return cleanedText == reversedText;
  }

  void _checkPalindrome() {
    String text = _palindromeController.text.trim();
    String message;

    if (text.isEmpty) {
      message = 'text empty, please input text';
    } else {
      bool palindrome = isPalindrome(text);
      message = palindrome ? 'is Palindrome' : 'not palindrome';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Palindrome Check'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen(currentUser: _nameController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 116,
                    width: 116,
                    decoration: BoxDecoration(
                        color: whiteColor30, shape: BoxShape.circle),
                    child: Icon(
                      Icons.person_add_alt_1,
                      size: 40,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(height: 51),
                  SizedBox(
                    height: 39.88,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle:
                            TextStyle(color: hintTextColor, fontSize: 16),
                        fillColor: whiteColor,
                        filled: true,
                        focusedBorder: textFieldOutlineInputBorder,
                        contentPadding: textFieldPadding,
                        border: textFieldOutlineInputBorder,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 39.88,
                    child: TextField(
                      controller: _palindromeController,
                      decoration: InputDecoration(
                        hintText: 'Palindrome',
                        hintStyle:
                            TextStyle(color: hintTextColor, fontSize: 16),
                        fillColor: whiteColor,
                        filled: true,
                        focusedBorder: textFieldOutlineInputBorder,
                        contentPadding: textFieldPadding,
                        border: textFieldOutlineInputBorder,
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),
                  ElevatedButton(
                    onPressed: _checkPalindrome,
                    style: elevatedButtonStyle,
                    child: Text(
                      'CHECK',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _goToNextScreen,
                    style: elevatedButtonStyle,
                    child: Text(
                      'NEXT',
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
          ],
        ),
      ),
    );
  }
}
