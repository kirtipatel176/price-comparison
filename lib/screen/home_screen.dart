import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsena/utility/large_butt.dart';
import 'package:tsena/utility/textformfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Text controllers
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: const Color(0xFF3B5998),
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Stack(
            children: [
              // First Positioned widget for ShareBible text and logo
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 60.0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.compare_rounded,
                            color: Color(0xFFFFFFFF)),
                        Text(
                          'Tsena',
                          style: GoogleFonts.inter(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                    MyTextFormField(
                      labelText: 'Item name',
                      icon: Icons.search_rounded,
                      obscureText: false,
                      controller: _searchController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    LargeButton(
                      icon: Icons.shopping_cart_rounded,
                      text: 'Search Item',
                      function: () {},
                    ),
                  ],
                ),
              ),
              // Positioned widget for background container
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 300.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                ),
              ),
              // Positioned widget for card
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 260.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: const Color(0xFFD3D3D3),
                        width: 0.4,
                      ),
                    ),
                    child: const Text('data'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
