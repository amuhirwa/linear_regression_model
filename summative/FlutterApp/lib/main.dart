import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Yield Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2E7D32),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
          secondary: const Color(0xFF66BB6A),
          tertiary: const Color(0xFFC8E6C9),
          background: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFC8E6C9), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                'assets/crop_logo.png',
                height: 120,
                width: 120,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.eco,
                  size: 100,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Crop Yield',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              Text(
                'Prediction System',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Welcome to Smart Farming',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Predict crop yields using advanced machine learning algorithms. Get accurate estimates based on environmental factors and agricultural practices.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PredictionPage()),
                            );
                          },
                          child: const Text('Start Predicting'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({Key? key}) : super(key: key);

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _rainfallController = TextEditingController();
  final TextEditingController _pesticidesController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();

  // Selected country and item
  String? _selectedCountry;
  String? _selectedItem;

  // Result variables
  bool _isLoading = false;
  String _resultText = '';
  bool _hasError = false;

  // Lists for dropdown menus
  final List<String> _countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Angola',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bangladesh',
    'Belarus',
    'Belgium',
    'Benin',
    'Bolivia',
    'Brazil',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Chile',
    'China',
    'Colombia',
    'Costa Rica',
    'Côte d\'Ivoire',
    'Croatia',
    'Cuba',
    'Denmark',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Estonia',
    'Ethiopia',
    'Finland',
    'France',
    'Germany',
    'Ghana',
    'Greece',
    'Guatemala',
    'Guinea',
    'Haiti',
    'Honduras',
    'Hungary',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Italy',
    'Jamaica',
    'Japan',
    'Kazakhstan',
    'Kenya',
    'Kyrgyzstan',
    'Latvia',
    'Lebanon',
    'Lithuania',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Mali',
    'Mexico',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Norway',
    'Pakistan',
    'Panama',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'Rwanda',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Sierra Leone',
    'South Africa',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tunisia',
    'Turkey',
    'Uganda',
    'Ukraine',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];

  final List<String> _items = [
    'Maize',
    'Wheat',
    'Rice',
    'Soybeans',
    'Potatoes',
    'Cassava',
    'Sweet potatoes',
    'Yams',
    'Sorghum',
    'Millet',
    'Oats',
    'Barley',
    'Rye',
    'Groundnuts',
    'Sunflower seed',
    'Rapeseed',
    'Cotton',
    'Sugarcane',
    'Sugar beet',
    'Coffee',
    'Cocoa',
    'Tea',
    'Tobacco',
    'Bananas',
    'Oranges',
    'Apples',
    'Grapes',
    'Olives',
    'Tomatoes',
    'Onions',
    'Carrots',
    'Cabbage',
    'Lettuce',
    'Beans',
    'Peas',
    'Lentils'
  ];

  @override
  void dispose() {
    _yearController.dispose();
    _rainfallController.dispose();
    _pesticidesController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  // Method to make API call
  Future<void> _predictYield() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _resultText = '';
      _hasError = false;
    });
    double predictedYield = 0;

    const apiUrl = 'https://crop-yield-predictor-rb5g.onrender.com/predict_yield';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Area': _selectedCountry,
          'Item': _selectedItem,
          'Year': int.parse(_yearController.text),
          'average_rain_fall_mm_per_year':
              double.parse(_rainfallController.text),
          'pesticides_tonnes': double.parse(_pesticidesController.text),
          'avg_temp': double.parse(_temperatureController.text),
        }),
      );

      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        predictedYield = data['predicted_yield'];
        setState(() {
          _resultText = 'Predicted Yield: ${data['predicted_yield']} hg/ha';
          _hasError = false;
        });
      } else {
        setState(() {
          _resultText = 'Error: ${response.statusCode} - ${response.body}';
          _hasError = true;
        });
        print('Error: ${response}');
      }
    } catch (e) {
      print('Error: ${e}');
      setState(() {
        _isLoading = false;
        _resultText = 'Error: $e';
        _hasError = true;
      });
    }
    // Navigate to results page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          country: _selectedCountry!,
          crop: _selectedItem!,
          yield: predictedYield.toString(),
          inputData: {
            'Year': _yearController.text,
            'Rainfall (mm/year)': _rainfallController.text,
            'Pesticides (tonnes)': _pesticidesController.text,
            'Avg. Temperature (°C)': _temperatureController.text,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          'Crop Yield Prediction',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Form title and description
                  const Text(
                    'Enter Prediction Parameters',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fill in all fields to get an accurate crop yield prediction',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Location & Crop Section
                  _buildSectionHeader('Location & Crop', Icons.place),
                  const SizedBox(height: 16),
                  
                  // Country dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      prefixIcon: Icon(Icons.public),
                    ),
                    value: _selectedCountry,
                    hint: const Text('Select Country'),
                    items: _countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a country';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Crop item dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Crop Type',
                      prefixIcon: Icon(Icons.eco),
                    ),
                    value: _selectedItem,
                    hint: const Text('Select Crop'),
                    items: _items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a crop type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Climate Information Section
                  _buildSectionHeader('Climate Information', Icons.water_drop),
                  const SizedBox(height: 16),
                  
                  // Year input
                  TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      hintText: 'Enter year (e.g., 2025)',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a year';
                      }
                      int? year = int.tryParse(value);
                      if (year == null || year < 1900 || year > 2050) {
                        return 'Please enter a valid year between 1900-2050';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Rainfall input
                  TextFormField(
                    controller: _rainfallController,
                    decoration: const InputDecoration(
                      labelText: 'Average Rainfall (mm/year)',
                      hintText: 'Enter average rainfall',
                      prefixIcon: Icon(Icons.water_drop),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rainfall value';
                      }
                      double? rainfall = double.tryParse(value);
                      if (rainfall == null || rainfall < 0 || rainfall > 5000) {
                        return 'Please enter a valid rainfall value (0-5000)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Temperature input
                  TextFormField(
                    controller: _temperatureController,
                    decoration: const InputDecoration(
                      labelText: 'Average Temperature (°C)',
                      hintText: 'Enter average temperature',
                      prefixIcon: Icon(Icons.thermostat),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter temperature value';
                      }
                      double? temp = double.tryParse(value);
                      if (temp == null || temp < -50 || temp > 60) {
                        return 'Please enter a valid temperature (-50 to 60°C)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Agricultural Practices Section
                  _buildSectionHeader('Agricultural Practices', Icons.pest_control),
                  const SizedBox(height: 16),
                  
                  // Pesticides input
                  TextFormField(
                    controller: _pesticidesController,
                    decoration: const InputDecoration(
                      labelText: 'Pesticides (tonnes)',
                      hintText: 'Enter pesticides amount',
                      prefixIcon: Icon(Icons.pest_control),
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pesticides value';
                      }
                      double? pesticides = double.tryParse(value);
                      if (pesticides == null || pesticides < 0) {
                        return 'Please enter a valid pesticides value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Information card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Ready to predict',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Click "Predict" to analyze your data and generate a crop yield forecast.',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Predict button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _isLoading ? null : _predictYield,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Predict Yield'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade800),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
      ],
    );
  }
}
class ResultsPage extends StatelessWidget {
  final String country;
  final String crop;
  // final IconData cropIcon;
  final String yield;
  final Map<String, String> inputData;

  const ResultsPage({
    Key? key,
    required this.country,
    required this.crop,
    // required this.cropIcon,
    required this.yield,
    required this.inputData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format yield with thousand separators
    final formattedYield = yield;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Prediction Results'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/results_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.85),
                BlendMode.lighten,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Results card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'Predicted Crop Yield',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Animated Container for the yield value
                          TweenAnimationBuilder(
                            duration: Duration(seconds: 1),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, double value, child) {
                              return Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green.shade100,
                                  border: Border.all(
                                    color: Colors.green.shade700,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.3),
                                      blurRadius: 12,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        formattedYield,
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                      Text(
                                        'hg/ha',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green.shade900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Input parameters summary
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.settings,
                                  color: Colors.green.shade700),
                              SizedBox(width: 12),
                              Text(
                                'Input Parameters',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...inputData.entries
                              .map((entry) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          entry.value,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Explanation card
                  Card(
                    elevation: 4,
                    color: Colors.amber.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: Colors.amber.shade800),
                              SizedBox(width: 12),
                              Text(
                                'What does this mean?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'The predicted yield is measured in hectograms per hectare (hg/ha). '
                            'This is a standard unit used by agricultural organizations to measure crop productivity. '
                            'For reference, 10,000 hg/ha equals 1 metric ton per hectare.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('New Prediction'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.home),
                          label: const Text('Home'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
