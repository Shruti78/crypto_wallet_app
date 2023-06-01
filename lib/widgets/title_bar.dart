import 'package:flutter/material.dart';

class TittleBar extends StatelessWidget {
  const TittleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
          left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Live Tracker",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "Filter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff5ED5A8),
              )
            ],
          ),
        ],
      ),
    );
  }
}