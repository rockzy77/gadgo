import 'package:flutter/material.dart';


class HomeSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function getSearchValue;
  const HomeSearchBar({required this.textController, required this.hintText, required this.getSearchValue});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
           controller: textController,
            onChanged: (value) {
              getSearchValue(value);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 2),),
              filled: true,
              fillColor: Color.fromARGB(255, 218, 218, 218),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
    );
  }
}