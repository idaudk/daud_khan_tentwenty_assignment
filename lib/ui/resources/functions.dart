import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getMonthNameFromNumber(int monthNumber) {
  if (monthNumber < 1 || monthNumber > 12) {
    return "Invalid Month";
  }

  // Create a DateFormat instance for formatting month names
  DateFormat dateFormat = DateFormat.MMMM();

  // Create a DateTime object with the given month number (assuming the year 2023)
  DateTime dateTime = DateTime(2023, monthNumber);

  // Format the DateTime to get the month name
  String monthName = dateFormat.format(dateTime);

  return monthName;
}

  final Random _random = Random();


Color randomColor() {
    final List<Color> colors = [
      Colors.white, // White with higher probability
      Colors.red[100]!, // Light Red
      Colors.orange[100]!, // Light Orange
      Colors.green[100]!, // Light Green
    ];

    final List<int> probabilities = [5, 1, 1, 1]; // Adjust probabilities here

    int totalProbability = probabilities.reduce((a, b) => a + b);
    int randomValue = _random.nextInt(totalProbability);

    int index = 0;
    for (int probability in probabilities) {
      if (randomValue < probability) {
        return colors[index];
      }
      randomValue -= probability;
      index++;
    }

    return colors.last; // Fallback to the last color
  }

  bool isEmailValid(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }