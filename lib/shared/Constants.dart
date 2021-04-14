import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
);

// List<ClusterLocation> savedList = [];

const List<String> dengueFacts = [
  'Papaya leaf extract can treat dengue fever.',
  'Fever and muscle pain from dengue lasts about one to two weeks',
  'Dengue is transmitted by Aedes mosquitoes',
  'Dengue fever may occur from 3 to 14 days after being bitten',
];

const List<String> highRiskValues = [
  'Wash your toilet',
  'Take out the trash',
  'Clear the drains',
  'Apply mosquito repellent',
  'Cover your pole holders',
  'Clear your water from trays',
  'Keep your water containers dry',
  'Use insecticide',
];

const List<String> mediumRiskValues = [
  'Wash your toilet',
  'Clear the drains',
  'Apply mosquito repellent',
  'Cover your pole holders',
  'Clear your water from trays',
  'Keep your water containers dry',
];

const List<String> lowRiskValues = [
  'Wash your toilet',
  'Clear the drains',
  'Clear your water from trays',
  'Keep your water containers dry'
];
const List<Map<String, Object>> questions = const [
  {
    'questionText': 'Are you living in a landed property?',
    'answers': [
      {'text': 'Yes', 'score': 10},
      {'text': 'No', 'score': 0},
    ],
  },
  {
    'questionText': 'Have any of your family members contracted dengue?',
    'answers': [
      {'text': 'Yes', 'score': 10},
      {'text': 'No', 'score': 0},
    ],
  },
  {
    'questionText': 'How often do you wash your toilet',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText': 'How often do you take out the trash?',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText':
        'How often do you clear the drains in or around your house?',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText': 'How often do you change the water for your plants?',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText': 'Do you cover your pole holders?',
    'answers': [
      {'text': 'Yes', 'score': 0},
      {'text': 'No', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText': 'How often do you clear water from dish rack trays?',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText':
        'Do you keep your water storage containers(e.g. pails) dry?',
    'answers': [
      {'text': 'Yes', 'score': 0},
      {'text': 'No', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
  {
    'questionText': 'How often do you use insecticide in your house?',
    'answers': [
      {'text': 'Daily', 'score': 0},
      {'text': 'Once a week', 'score': 3},
      {'text': 'Once in 2 weeks', 'score': 6},
      {'text': 'Once a month', 'score': 10},
      {'text': 'Not applicable', 'score': 0},
    ],
  },
];
