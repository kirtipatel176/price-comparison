import 'package:flutter/material.dart';

class NodataScreen extends StatelessWidget {
  const NodataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Third Positioned widget for no data if user have not made a search yet
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: 260.0,

      // Padding around container for displaying no data
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),

        // Container for displaying no data
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + 100.0,
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
          child: Center(
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
