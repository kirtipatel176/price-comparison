import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NodataScreen extends StatelessWidget {
  const NodataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // action list
    final List<Map<String, dynamic>> actionsList = [
      {'name': 'Think', 'icon': Icons.lightbulb},
      {'name': 'Search', 'icon': Icons.search},
      {'name': 'Compare', 'icon': Icons.compare},
      {'name': 'Shop', 'icon': Icons.shopping_cart},
      {'name': 'AI Suggestions', 'icon': Icons.psychology},
    ];

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(height: 1.2),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Search For ',
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                    TextSpan(
                      text: 'Products \n',
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [Color(0xFFFF6F61), Color(0xFF3B5998)],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                          ).createShader(
                            Rect.fromLTWH(0.0, 0.0, 1000.0, 14.0),
                          ),
                      ),
                    ),
                    TextSpan(
                      text: 'Efficiently At No Cost',
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),

              // Padding around various action list in a wrap
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                ),

                // Wrap starts here
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Wrap(
                      children: actionsList.map((action) {
                        return Container(
                          padding: const EdgeInsets.all(3.0),
                          margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xFFF9F9FA),
                          ),

                          // Container for each action
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 8.0,
                              bottom: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF)
                                  .withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(20.0),
                            ),

                            // Text for each action
                            child: Text(
                              action['name'],
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                // Wrap ends here
              ),
            ],
          ),
        ),
      ),
    );
  }
}
