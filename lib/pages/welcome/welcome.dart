import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litbebe/pages/login/login.dart';
import 'package:litbebe/pages/signup/signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3EED2),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFB3CEDB),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/baby_logo1-removebg-preview.png',
                  width: 500,
                  height: 428,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Text(
                    'Bienvenue',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF6E5435),
                      fontSize: 70,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: SizedBox(
                    width: 303,
                    height: 63,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor : const Color(0xFFFBF9F9),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                        textStyle: GoogleFonts.roboto(
                          color: const Color(0xFF6E5435),
                          fontSize: 30,
                          letterSpacing: 0,
                        ),
                      ),
                      child: const Text('se connecter'),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: SizedBox(
                    width: 303,
                    height: 63,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor : const Color(0xFFFBF9F9),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 3,
                        textStyle: GoogleFonts.roboto(
                          color: const Color(0xFF6E5435),
                          fontSize: 30,
                          letterSpacing: 0,
                        ),
                      ),
                      child: const Text('s\'inscrire'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

