import 'package:flutter/material.dart';
import 'package:flutter_netflix_clone/core/constants/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(
              Assets.assetsEogflixLogo,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Sun Eog',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 140,
          height: 5,
          padding: EdgeInsets.all(15),
          color: Colors.red,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () async {
              final url = Uri.parse('https://github.com/suneogkwon');
              await launchUrl(url);
            },
            child: Text('https://github.com/suneogkwon'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              shape: BeveledRectangleBorder(),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  '프로필 수정하기',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
