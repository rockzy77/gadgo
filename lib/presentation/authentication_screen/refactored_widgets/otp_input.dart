import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        width: 55,
        child: TextField(
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            filled: true,
                    fillColor: Color.fromARGB(87, 26, 26, 26),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white,width: 2)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white, width: 2)
              ),
              counterText: '',
              hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}