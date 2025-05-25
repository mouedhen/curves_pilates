import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default to Home

  final List<Map<String, dynamic>> actions = [
    {'icon': Icons.person_outline, 'title': 'Mon espace'},
    {'icon': Icons.calendar_today_outlined, 'title': 'Reserver une séance'},
    {'icon': Icons.card_membership_outlined, 'title': 'Nos abonnements'},
    {'icon': Icons.history_outlined, 'title': 'Mon historique'},
    {'icon': Icons.contact_phone_outlined, 'title': 'Contact'},
    {'icon': Icons.rule_folder_outlined, 'title': 'Règlement intérieur'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accueil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false, // Left-align the title
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 24, color: Colors.grey[700]),
            onPressed: () {
              // Handle search action
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none_outlined, size: 24, color: Colors.grey[700]),
            onPressed: () {
              // Handle notifications action
            },
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, size: 24, color: Colors.grey[700]),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // For left-aligning the title
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.grey[200],
            child: const Center(
              child: Text('Notification Area'),
            ),
          ),
          const SizedBox(height: 12), // Adjusted Margin above the banner
          Container(
            height: 150,
            color: Colors.blueGrey[100],
            child: const Center(
              child: Text('Publicity Banner'),
            ),
          ),
          const SizedBox(height: 15), // Margin above "Actions Rapides" title
          const Padding(
            padding: EdgeInsets.only(left: 16.0), // Left-align title
            child: Text(
              'Actions Rapides',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10), // Margin between title and GridView
          Expanded(
            child: Padding( // Added padding around GridView
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: actions.map((action) {
                  return _buildActionCard(
                    context,
                    action['icon'] as IconData,
                    action['title'] as String,
                    () {
                      // Handle card tap
                      // print('${action['title']} tapped');
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Using Colors.blue for now
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell( // Using InkWell for tap effect and semantics
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0), // Match border radius for ripple effect
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.blueGrey[700]), // Icon size and color
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
