
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FiltersSection extends StatelessWidget {
  final void Function(String?) onDomainChanged;
  final void Function(String?) onGenderChanged;
  final void Function(bool) onAvailabilityChanged;

  FiltersSection({
    required this.onDomainChanged,
    required this.onGenderChanged,
    required this.onAvailabilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DropdownButton<String>(
          hint: Text('Select Domain'),
          onChanged: onDomainChanged,
          items: ['Sales', 'IT', 'Finance', 'Marketing'].map((String domain) {
            return DropdownMenuItem<String>(
              value: domain,
              child: Text(domain),
            );
          }).toList(),
        ),
        DropdownButton<String>(
          hint: Text('Select Gender'),
          onChanged: onGenderChanged,
          items: ['Male', 'Female'].map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
        Row(
          children: [
            Text('Available'),
            Switch(
              value: true, // Set the value to selectedAvailability
              onChanged: onAvailabilityChanged,
            ),
          ],
        ),
      ],
    );
  }
}
