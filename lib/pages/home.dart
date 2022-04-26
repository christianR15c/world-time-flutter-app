// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore, avoid_print, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    print(data['isDaytime']);

    String bgImage = data['isDaytime']
        ? 'https://res.cloudinary.com/dmgfxu4fg/image/upload/v1650916546/day_a0i9er.png'
        : 'https://res.cloudinary.com/dmgfxu4fg/image/upload/v1650916548/night_mosagp.png';

    Color color = data['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage('$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic results =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': results['time'],
                        'location': results['location'],
                        'isDaytime': results['isDaytime'],
                        'flag': results['flag']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: color,
                  ),
                  label: Text(
                    'Edit location',
                    style: TextStyle(color: color),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 28, letterSpacing: 2, color: color),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 66, color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
