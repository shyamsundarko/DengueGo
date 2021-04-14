import '../widgets/InfoVideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'FAQ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
        Text(
          'How do I report dengue in Singapore?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'To report potential mosquito breeding sites to NEA, '
          '\n'
          'please call 1800-2255-632 or Contact_NEA@nea.gov.sg.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'How effective is the survey?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'The survey helps to determine the dengue '
          '\n'
          'risk level of your home.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'How do I share this application?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Do help spread to your loved ones'
          '\n'
          'to help them stay safe!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        Flexible(
          child: InfoVideoController(
            videoPlayerController:
                VideoPlayerController.asset('videos/dengue.mp4'),
          ),
        ),
      ],
    );
  }
}
