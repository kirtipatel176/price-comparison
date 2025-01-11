import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  //  searchProduct function
  Future<void> searchProduct(String query) async {
    final url = Uri.parse('https://pricer.p.rapidapi.com/str?q=$query');

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-host': 'pricer.p.rapidapi.com',
          'x-rapidapi-key': '',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _searchResults = data;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter product name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String query = _searchController.text.trim();
                if (query.isNotEmpty) {
                  await searchProduct(query);
                } else {
                  print('Please enter a product name');
                }
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            // Display search results if available
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index].toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
