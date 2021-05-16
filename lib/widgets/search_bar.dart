import 'package:flutter/material.dart';
//import '../helpers/text_styles.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: TextFormField(
        controller: new TextEditingController(),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF98A0A6),
              size: 20,
            ),
            hintText: "what you are looking at",
            contentPadding: const EdgeInsets.only(top: 13),
            hintStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            labelStyle: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: const Color(0xFF98A0A6),
                  size: 20,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.mic,
                  color: const Color(0xFF98A0A6),
                  size: 20,
                ),
                SizedBox(width: 15),
              ],
            )),
      ),
    );
  }
}
