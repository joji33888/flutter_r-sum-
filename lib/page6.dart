import 'package:flutter/material.dart';

class Page6 extends StatefulWidget {
  const Page6({super.key});

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  final List<Map<String, dynamic>> _weatherData = [
    {
      'city': 'New York',
      'temperature': 18,
      'condition': 'Partly Cloudy',
      'icon': Icons.cloud,
      'color': Colors.blue[300],
    },
    {
      'city': 'London',
      'temperature': 15,
      'condition': 'Rainy',
      'icon': Icons.water_drop,
      'color': Colors.grey[400],
    },
    {
      'city': 'Tokyo',
      'temperature': 25,
      'condition': 'Sunny',
      'icon': Icons.wb_sunny,
      'color': Colors.orange,
    },
    {
      'city': 'Paris',
      'temperature': 20,
      'condition': 'Clear',
      'icon': Icons.nightlight_round,
      'color': Colors.indigo[300],
    },
    {
      'city': 'Sydney',
      'temperature': 28,
      'condition': 'Hot',
      'icon': Icons.thermostat,
      'color': Colors.red[400],
    },
  ];

  String _selectedCity = 'New York';

  Map<String, dynamic> get _currentWeather {
    return _weatherData.firstWhere(
      (weather) => weather['city'] == _selectedCity,
      orElse: () => _weatherData[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App'), backgroundColor: Colors.teal),
      body: Column(
        children: [
          // City selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select City',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: _selectedCity,
              items:
                  _weatherData
                      .map<DropdownMenuItem<String>>(
                        (weather) => DropdownMenuItem<String>(
                          value: weather['city'] as String,
                          child: Text(weather['city'] as String),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCity = value;
                  });
                }
              },
            ),
          ),

          // Weather display
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _currentWeather['color'],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_currentWeather['icon'], size: 100, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    '${_currentWeather['temperature']}°C',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _currentWeather['condition'],
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _selectedCity,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Forecast section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other Cities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _weatherData.length,
                    itemBuilder: (context, index) {
                      final weather = _weatherData[index];
                      return Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: weather['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(weather['icon'], color: Colors.white),
                            Text(
                              '${weather['temperature']}°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              weather['city'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
