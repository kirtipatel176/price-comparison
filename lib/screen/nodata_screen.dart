import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: RichText(
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
                          colors: [Color(0xFF00FF00), Color(0xFF0000FF)],
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
          ),
        ),
      ),
    );
  }
}
