// Import the Flutter Material Design package which provides visual widgets and components
import 'package:flutter/material.dart';

// Main Page2 widget that extends StatefulWidget
// StatefulWidget is used because this page needs to maintain state that changes over time
class Page2 extends StatefulWidget {
  // Constructor with optional key parameter for widget identification
  const Page2({super.key});

  @override
  // Creates the mutable state for this widget at a given location in the tree
  State<Page2> createState() => _Page2State();
}

// The state class for Page2 which contains all the mutable state and UI logic
class _Page2State extends State<Page2> {
  // User input variables and state management
  bool isMale = true; // Gender selection (true for male, false for female)
  DateTime? selectedDate; // User's birth date (nullable)
  double height = 1.5; // Height in meters with default value
  TextEditingController weightController =
      TextEditingController(); // Controller for weight input field
  String workoutFrequency = 'rare'; // Default workout frequency selection
  String? calculationType; // Type of calculation to perform (BMI or TDEE)
  String resultText = ''; // Text to display calculation results

  // Activity factors used in TDEE (Total Daily Energy Expenditure) calculation
  // These multipliers represent different activity levels and their impact on calorie needs
  final Map<String, double> activityFactors = {
    'rare': 1.2, // Sedentary (little or no exercise)
    'medium': 1.55, // Moderate activity (moderate exercise 3-5 days/week)
    'regular': 1.9, // Very active (hard exercise 6-7 days/week)
  };

  // Function to display a date picker dialog and handle the selected date
  // Returns a Future that completes when the user selects a date or dismisses the dialog
  Future<void> _selectDate(BuildContext context) async {
    // Show the date picker dialog and wait for user selection
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          selectedDate ??
          DateTime(2000), // Default to year 2000 if no date is selected
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date (current date)
    );

    // Update the state only if a date was picked and it's different from the current selection
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update the selected date in the state
      });
    }
  }

  // Calculate the user's age based on the selected birth date
  // Returns the age in years as an integer
  int getAge() {
    // Return 0 if no birth date has been selected
    if (selectedDate == null) return 0;

    // Get the current date for comparison
    final today = DateTime.now();

    // Calculate age by subtracting birth year from current year
    int age = today.year - selectedDate!.year;

    // Adjust age if birthday hasn't occurred yet this year
    // This handles cases where the current date is before the birthday in the current year
    if (today.month < selectedDate!.month ||
        (today.month == selectedDate!.month && today.day < selectedDate!.day)) {
      age--; // Subtract 1 from age if birthday hasn't occurred yet this year
    }

    return age;
  }

  // Main calculation function that computes either BMI or TDEE based on user input
  void calculate() {
    // Get the user's age from the birth date
    final age = getAge();

    // Parse the weight from the text input field, defaulting to 0 if invalid
    final weight = double.tryParse(weightController.text) ?? 0;

    // Get the height value in meters
    final heightMeters = height;

    // Validate that we have positive values for age and weight
    if (age <= 0 || weight <= 0) {
      setState(() {
        resultText = 'Please enter valid age and weight.'; // Show error message
      });
      return; // Exit the function early if validation fails
    }

    // Calculate BMI (Body Mass Index) if that calculation type is selected
    if (calculationType == 'BMI') {
      // BMI formula: weight (kg) / (height (m) * height (m))
      final bmi = weight / (heightMeters * heightMeters);

      setState(() {
        resultText =
            'Your BMI is ${bmi.toStringAsFixed(2)}'; // Display BMI result with 2 decimal places
      });
    }
    // Calculate TDEE (Total Daily Energy Expenditure) if BMI is not selected
    else {
      // Calculate BMR (Basal Metabolic Rate) using Mifflin-St Jeor Equation
      double bmr;

      // Different formulas for male and female
      if (isMale) {
        // Male BMR formula: 10*weight + 6.25*height(cm) - 5*age + 5
        bmr = 10 * weight + 6.25 * (heightMeters * 100) - 5 * age + 5;
      } else {
        // Female BMR formula: 10*weight + 6.25*height(cm) - 5*age - 161
        bmr = 10 * weight + 6.25 * (heightMeters * 100) - 5 * age - 161;
      }

      // Calculate TDEE by multiplying BMR by activity factor
      // Default to 1.2 (sedentary) if workout frequency is not found in the map
      final tdee = bmr * (activityFactors[workoutFrequency] ?? 1.2);

      setState(() {
        resultText =
            'Your TDEE is ${tdee.toStringAsFixed(2)} kcal'; // Display TDEE result with 2 decimal places
      });
    }
  }

  // Clean up resources when the widget is removed from the widget tree
  @override
  void dispose() {
    // Dispose of the TextEditingController to prevent memory leaks
    weightController.dispose();
    // Call the parent class dispose method
    super.dispose();
  }

  // Build method that creates the UI of the widget
  @override
  Widget build(BuildContext context) {
    // Set the app bar color based on gender selection (blue for male, red for female)
    final topBarColor = isMale ? Colors.blue : Colors.red;

    // Main scaffold widget that provides the basic structure for the page
    return Scaffold(
      // App bar with title and dynamic background color
      appBar: AppBar(
        title: Text('calories calculator'),
        backgroundColor: topBarColor, // Color changes based on gender selection
      ),
      // Main content area with scrolling enabled
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16), // Add padding around all content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
            children: [
              // Header row with title text
              Row(
                children: [
                  Text(
                    'fill your information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16), // Vertical spacing
              // Main form content with padding
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Gender selection row with icons and switch
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Center the gender selection controls
                      children: [
                        // Female icon - highlighted when female is selected
                        Icon(
                          Icons.female,
                          color:
                              isMale
                                  ? Colors.grey
                                  : Colors
                                      .red, // Grey when not selected, red when selected
                          size: 40,
                        ),
                        // Switch toggle between male and female
                        Switch(
                          value: isMale, // Current gender selection state
                          onChanged: (value) {
                            // Update the gender selection when switch is toggled
                            setState(() {
                              isMale = value;
                            });
                          },
                          activeColor:
                              Colors.blue, // Blue when switch is on (male)
                          inactiveThumbColor:
                              Colors.red, // Red when switch is off (female)
                          inactiveTrackColor:
                              Colors
                                  .red[200], // Light red track when switch is off
                        ),
                        // Male icon - highlighted when male is selected
                        Icon(
                          Icons.male,
                          color:
                              isMale
                                  ? Colors.blue
                                  : Colors
                                      .grey, // Blue when selected, grey when not selected
                          size: 40,
                        ),
                      ],
                    ),
                    SizedBox(height: 16), // Vertical spacing
                    // Date picker field for selecting birth date
                    // GestureDetector makes the entire field tappable to show date picker
                    GestureDetector(
                      onTap:
                          () => _selectDate(
                            context,
                          ), // Show date picker when tapped
                      child: AbsorbPointer(
                        // AbsorbPointer prevents direct text input, forcing use of date picker
                        child: TextFormField(
                          decoration: InputDecoration(
                            // Dynamic label text that shows age if date is selected
                            labelText:
                                selectedDate == null
                                    ? 'Enter your age' // Default text when no date selected
                                    : 'Age: ${getAge()} years', // Show calculated age when date is selected
                            suffixIcon: Icon(
                              Icons.calendar_today,
                            ), // Calendar icon
                            border:
                                OutlineInputBorder(), // Border around the field
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16), // Vertical spacing
                    // Height selection with slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display current height value
                        Text('Height: ${height.toStringAsFixed(2)} m'),
                        // Slider for adjusting height
                        Slider(
                          value: height, // Current height value
                          min: 1.0, // Minimum height (1 meter)
                          max: 2.0, // Maximum height (2 meters)
                          divisions:
                              100, // Divides range into 100 steps (1cm increments)
                          label:
                              '${height.toStringAsFixed(2)} m', // Tooltip showing current value
                          onChanged: (value) {
                            // Update height when slider is moved
                            setState(() {
                              height = value;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16), // Vertical spacing
                    // Weight input field
                    TextFormField(
                      controller:
                          weightController, // Controller for accessing the input value
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true, // Allow decimal input for precise weight
                      ),
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)', // Label for the field
                        border: OutlineInputBorder(), // Border around the field
                      ),
                    ),
                    SizedBox(height: 16), // Vertical spacing
                    // Workout frequency section
                    Text('How many times you workout?'), // Section header
                    Column(
                      children: [
                        // Radio button for 'rare' workout frequency
                        RadioListTile<String>(
                          title: Text('rare'), // Option label
                          value: 'rare', // Option value
                          groupValue:
                              workoutFrequency, // Currently selected value
                          onChanged: (value) {
                            // Update workout frequency when this option is selected
                            setState(() {
                              workoutFrequency = value!;
                            });
                          },
                        ),
                        // Radio button for 'medium' workout frequency
                        RadioListTile<String>(
                          title: Text('medium'), // Option label
                          value: 'medium', // Option value
                          groupValue:
                              workoutFrequency, // Currently selected value
                          onChanged: (value) {
                            // Update workout frequency when this option is selected
                            setState(() {
                              workoutFrequency = value!;
                            });
                          },
                        ),
                        // Radio button for 'regular' workout frequency
                        RadioListTile<String>(
                          title: Text('regular'), // Option label
                          value: 'regular', // Option value
                          groupValue:
                              workoutFrequency, // Currently selected value
                          onChanged: (value) {
                            // Update workout frequency when this option is selected
                            setState(() {
                              workoutFrequency = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16), // Vertical spacing
                    // Dropdown for selecting calculation type (BMI or TDEE)
                    DropdownButtonFormField<String>(
                      value:
                          calculationType, // Currently selected calculation type
                      items:
                          // Create dropdown items from the list of calculation types
                          ['TDEE', 'BMI']
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (value) {
                        // Update calculation type when a new option is selected
                        setState(() {
                          calculationType = value;
                          resultText = ''; // Clear previous results
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Calculation', // Field label
                        border: OutlineInputBorder(), // Border around the field
                      ),
                    ),

                    SizedBox(height: 16), // Vertical spacing
                    // Calculation button row - only shown when a calculation type is selected
                    if (calculationType != null)
                      Row(
                        children: [
                          // Icon that changes based on calculation type
                          Icon(
                            calculationType == 'TDEE'
                                ? Icons
                                    .fitness_center // Fitness icon for TDEE
                                : Icons.monitor_weight, // Weight icon for BMI
                            size: 24,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 8), // Horizontal spacing
                          // Text showing which calculation will be performed
                          Text(
                            'Calculate your $calculationType',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(), // Pushes the button to the right side
                          // Calculate button
                          IconButton(
                            icon: Icon(Icons.check), // Checkmark icon
                            onPressed:
                                calculate, // Call calculate method when pressed
                          ),
                        ],
                      ),
                    SizedBox(height: 16), // Vertical spacing
                    // Result display - only shown when there is a result to display
                    if (resultText.isNotEmpty)
                      Text(
                        resultText, // Display the calculation result
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold, // Make result text stand out
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} // End of _Page2State class
