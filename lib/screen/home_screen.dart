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
              // First Positioned widget here
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 60.0,

                // Column for first expanded widget items
                child: Column(
                  children: [
                    // Row for compare icon and tsena text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Compare icon
                        const Icon(Icons.compare_rounded,
                            color: Color(0xFFFFFFFF)),

                        // Tsena text
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

                    // Textformfield for entering item for search
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

                    // Button for performing search
                    LargeButton(
                      icon: Icons.shopping_cart_rounded,
                      text: 'Search Item',
                      function: () {},
                    ),
                  ],
                ),
              ),

              // Second Positioned widget here
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

              // Third Positioned widget for card (displaying details of single item)
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 260.0,

                // Padding around container for displaying single item details
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),

                  // Container for displaying dingle item details
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.inter(height: 1.2),
                            children: <TextSpan>[
                              TextSpan(
                                text: '9 PLAY by Bang & Olufsen Beoplay H4 \n',
                                style: GoogleFonts.inter(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000)),
                              ),
                              TextSpan(
                                text: '\$99.99',
                                style: GoogleFonts.inter(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF696969)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
