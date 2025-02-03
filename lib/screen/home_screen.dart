import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsena/screen/loading_screen.dart';
import 'package:tsena/screen/nodata_screen.dart';
import 'package:tsena/utility/large_button.dart';
import 'package:tsena/utility/small_button.dart';
import 'package:tsena/utility/textformfield.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Text controllers
  final _searchController = TextEditingController();

  // Search results List
  List<dynamic> _searchResults = [];

  int _currentIndex = 0;

  // Loading state
  bool _isLoading = false;

  final List<Map<String, dynamic>> itemList = [
    {
      'price': 120.0,
      'star': 5,
      'reviews': 487,
      'shop': 'assets/images/amazon.png',
      'stockType': 'In Stock',
      'numberOfDays': 1,
      'shipping': 'Free Shipping',
    },
  ];

  //  searchProduct function
  Future<void> searchProduct(String query) async {
    // Ensure that _searchController is not empty
    if (_searchController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'What are you searching?',
              style: GoogleFonts.inter(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://pricer.p.rapidapi.com/str?q=$query');

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-host': 'pricer.p.rapidapi.com',
          'x-rapidapi-key': '${dotenv.env['token']}',
        },
      );

      // Print
      // print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _searchResults = data;
          _isLoading = false;

          // Save the search results to SharedPreferences
          _saveSearchResultsToSharedPreferences(data);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                'Request failed with status: ${response.statusCode}.',
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Error occurred: $e.',
              style: GoogleFonts.inter(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
      print('Error occurred: $e');
    }
  }

  // Function to save search results to SharedPreferences
  Future<void> _saveSearchResultsToSharedPreferences(
      List<dynamic> results) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String resultsString = jsonEncode(results);
    await prefs.setString('search_results', resultsString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B5998),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
                    ),

                    // Button for performing search
                    LargeButton(
                      icon: Icons.shopping_cart_rounded,
                      text: 'Search Item',
                      function: () {
                        // Call the searchProduct function with the query from the TextField
                        String query = _searchController.text;
                        searchProduct(query);
                      },
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

              _isLoading
                  ? LoadingScreen()
                  : _searchResults.isEmpty
                      ? NodataScreen()
                      : Positioned(
                          left: 0.0,
                          right: 0.0,
                          top: 260.0,
                          child: Column(
                            children: [
                              // In your widget's build method, wrap the stateful logic:
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                      Container(
                                        height: 40.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0.5),
                                            topRight: Radius.circular(0.5),
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: const Color(0xFFD3D3D3),
                                              width: 0.4,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                final link = _searchResults[
                                                    _currentIndex]['link'];
                                                if (link != null &&
                                                    await canLaunchUrl(
                                                        Uri.parse(link))) {
                                                  await launchUrl(
                                                      Uri.parse(link),
                                                      mode: LaunchMode
                                                          .externalApplication);
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                width: 156.0,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: const Color(
                                                          0xFFD3D3D3),
                                                      width: 0.4,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: const Color(
                                                          0xFFFF6F61),
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Visit Website',
                                                      style: GoogleFonts.inter(
                                                        color:
                                                            Color(0xFFFF6F61),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 3.0),
                                                    Icon(
                                                      Icons
                                                          .open_in_browser_rounded,
                                                      size: 20.0,
                                                      color: Color(0xFFFF6F61),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 156.0,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFFFFFF)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // Back Button
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        // Update the index to show the previous item
                                                        if (_currentIndex > 0) {
                                                          _currentIndex--;
                                                        } else {
                                                          _currentIndex = 0;
                                                        }
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_left,
                                                          color:
                                                              Color(0xFF696969),
                                                        ),
                                                        Text(
                                                          'Back',
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: Color(
                                                                0xFF696969),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Next Button
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        // Update the index to show the next item
                                                        if (_currentIndex <
                                                            _searchResults
                                                                    .length -
                                                                1) {
                                                          _currentIndex++;
                                                        } else {
                                                          _currentIndex =
                                                              0; // Go back to the first item
                                                        }
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Next',
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: Color(
                                                                0xFF696969),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color:
                                                              Color(0xFF696969),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              '${_searchResults[_currentIndex]['title'] ?? 'No Title'} \n',
                                              style: GoogleFonts.inter(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF000000)),
                                            ),
                                            Text(
                                              textAlign: TextAlign.center,
                                              '${_searchResults[_currentIndex]['price'] ?? 'N/A'}',
                                              style: GoogleFonts.inter(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF696969),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Image.network(
                                          _searchResults[_currentIndex]
                                                  ['img'] ??
                                              '',
                                          height: 200.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.image,
                                                size: 100);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _searchResults.length > 4
                                      ? 4
                                      : _searchResults.length,
                                  itemBuilder: (context, index) {
                                    final item = _searchResults[
                                        _searchResults.length - 1 - index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0),
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        width: 250.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                            color: const Color(0xFFD3D3D3),
                                            width: 0.4,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Title
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: Text(
                                                item['title'],
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inter(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF000000),
                                                ),
                                              ),
                                            ),

                                            // Shop and Price
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item['shop']
                                                              .replaceFirst(
                                                                  'from ', ''),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xFF696969),
                                                          ),
                                                        ),
                                                        Text(
                                                          item['price']
                                                              .toString()
                                                              .replaceAll(
                                                                  RegExp(
                                                                      'used|refurbished',
                                                                      caseSensitive:
                                                                          false),
                                                                  ''),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xFF696969),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Rating and Reviews
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Item rating
                                                          Row(
                                                            children:
                                                                List.generate(
                                                              int.parse(item[
                                                                      'rating']
                                                                  .split(' ')[0]
                                                                  .split(
                                                                      '.')[0]),
                                                              (starIndex) =>
                                                                  const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: 16.3,
                                                              ),
                                                            ),
                                                          ),

                                                          // Item reviews
                                                          Text(
                                                            '${item['reviews']} REVIEWS',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xFFFF6F61),
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  Color(
                                                                      0xFFFF6F61),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Spacer to push the button to the bottom
                                            Spacer(),

                                            // Small Button here
                                            SmallButton(
                                              icon:
                                                  Icons.open_in_browser_rounded,
                                              text: 'Visit Site',
                                              function: () async {
                                                final link = item['link'];
                                                if (link != null &&
                                                    await canLaunchUrl(
                                                        Uri.parse(link))) {
                                                  await launchUrl(
                                                    Uri.parse(link),
                                                    mode: LaunchMode
                                                        .externalApplication,
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
