import 'dart:convert';
import 'package:flutter/material.dart';
import 'user_cart.dart';
import 'user.dart';
import 'filters_section.dart';

// ignore: use_key_in_widget_constructors
class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<User> users = [];
  String searchQuery = '';
  String selectedDomain = '';
  String selectedGender = '';
  bool selectedAvailability = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final String data = await DefaultAssetBundle.of(context).loadString('assets/heliverse_mock_data.json');
    final List<dynamic> jsonList = json.decode(data);

    setState(() {
      users = jsonList.map((json) => User.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<User> filteredUsers = users.where((user) {
      return user.firstName.toLowerCase().contains(searchQuery.toLowerCase()) &&
          (selectedDomain.isEmpty || user.domain == selectedDomain) &&
          (selectedGender.isEmpty || user.gender == selectedGender) &&
          (!selectedAvailability || user.available == selectedAvailability);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Management App'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                searchQuery = '';
                selectedDomain = '';
                selectedGender = '';
                selectedAvailability = false;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          FiltersSection(
            onDomainChanged: (String? domain) {
              setState(() {
                selectedDomain = domain ?? '';
              });
            },
            onGenderChanged: (String? gender) {
              setState(() {
                selectedGender = gender ?? '';
              });
            },
            onAvailabilityChanged: (bool availability) {
              setState(() {
                selectedAvailability = availability;
              });
            },
          ),
          _buildFilterDisplay(), // Display applied filters
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return UserCard(user: filteredUsers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDisplay() {
    List<String> appliedFilters = [];
    if (selectedDomain.isNotEmpty) {
      appliedFilters.add('Domain: $selectedDomain');
    }
    if (selectedGender.isNotEmpty) {
      appliedFilters.add('Gender: $selectedGender');
    }
    if (selectedAvailability) {
      appliedFilters.add('Available');
    }

    if (appliedFilters.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Wrap(
        spacing: 8.0,
        children: [
          Text(
            'Filters Applied:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          ...appliedFilters.map((filter) => Chip(
                label: Text(
                  filter,
                  style: TextStyle(color: Colors.blue),
                ),
                backgroundColor: Colors.blue.withOpacity(0.1),
              )),
        ],
      ),
    );
  }
}
