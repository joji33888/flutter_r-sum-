import 'package:flutter/material.dart';
import 'package:test_tp2/page1.dart';
import 'package:test_tp2/page2.dart';
import 'package:test_tp2/page3.dart';
import 'package:test_tp2/page4.dart';
import 'package:test_tp2/page5.dart';
import 'package:test_tp2/page6.dart';
import 'package:test_tp2/profile.dart';
import 'package:test_tp2/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper method to build navigation buttons with consistent styling
  Widget _buildNavButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withAlpha(51), // ~0.2 opacity
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(77), // ~0.3 opacity
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: 30),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = context.findAncestorStateOfType<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TP",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 201, 132, 11),
        actions: [
          IconButton(
            icon: Icon(
              myAppState?.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              myAppState?.changeTheme(
                myAppState.themeMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              );
            },
          ),
        ],
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          backgroundColor: const Color.fromARGB(
            255,
            105,
            180,
            241,
          ).withAlpha(128), // ~0.5 opacity
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("My Profile"),
                accountEmail: const Text("example@gmail.com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50),
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 129, 47),
                ),
              ),
              ExpansionTile(
                leading: const Icon(Icons.group),
                title: const Text("Groups"),
                trailing: const Icon(
                  Icons.arrow_drop_down,
                ), // Changed to arrow_drop_down for ExpansionTile
                children: <Widget>[
                  ListTile(
                    title: const Text("Group 1"),
                    onTap: () {
                      // Navigate to group 1 page
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text("Group 2"),
                    onTap: () {
                      // Navigate to group 2 page
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: "Add Friends",
                  border: OutlineInputBorder(),
                ),
                items:
                    <String>[
                      'Friend 1',
                      'Friend 2',
                      'Friend 3',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  // Handle the selection
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text("Help"),
                onTap: () {
                  // Navigate to help page
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  // Navigate to settings page
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About"),
                onTap: () {
                  // Navigate to about page
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.orange.withAlpha(51)], // ~0.2 opacity
          ),
        ),
        child: Column(
          children: [
            // Search bar with improved styling
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.orange[700]),
                  suffixIcon: Icon(Icons.mic, color: Colors.orange[700]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.orange.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: Colors.orange.shade500,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),

            // App title
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Navigation Menu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
            ),

            // First row of icons with improved styling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton(
                    context: context,
                    icon: Icons.pageview,
                    label: "Page 1",
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page1()),
                      );
                    },
                  ),
                  _buildNavButton(
                    context: context,
                    icon: Icons.pages,
                    label: "Page 2",
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page2()),
                      );
                    },
                  ),
                  _buildNavButton(
                    context: context,
                    icon: Icons.home,
                    label: "Page 4",
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page4()),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Second row of icons with improved styling
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavButton(
                    context: context,
                    icon: Icons.person,
                    label: "Page 3",
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page3()),
                      );
                    },
                  ),
                  _buildNavButton(
                    context: context,
                    icon: Icons.task_alt,
                    label: "Tasks",
                    color: Colors.purple,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page5()),
                      );
                    },
                  ),
                  _buildNavButton(
                    context: context,
                    icon: Icons.cloud,
                    label: "Weather",
                    color: Colors.teal,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page6()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Expanded section with a card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 50,
                          color: Colors.orange[700],
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Welcome to the App",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Select an icon above to navigate to different pages",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 201, 132, 11),
        child: Image.asset('assets/img/information.png'),
      ),
    );
  }
}
