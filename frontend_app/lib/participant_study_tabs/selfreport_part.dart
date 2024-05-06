import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_app/models/datapoint.dart';
import 'package:frontend_app/services/api_service.dart';

class SelfReport extends StatefulWidget {
  const SelfReport({super.key});

  @override
  State<SelfReport> createState() => _SelfReportState();
}

class _SelfReportState extends State<SelfReport> {
  late DataPoint p1, p2;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isValidValue(String str) {
    final number = double.tryParse(str);
    if (number == null) {
      return false;
    }
    return true;
  }

  void _saveData() async {
    if (!_isValidValue(heightController.text) && !_isValidValue(weightController.text)) {
      _showErrorSnackBar("Invalid input: Please ensure all fields are numbers.");
    } else {
      p1 = DataPoint(
      userId:12,
      name: "Weight",
      value: double.tryParse(weightController.text),
      collectionDate: DateTime.now().toString(),
      collectionType: 0
    );
    print("Height: ${heightController.text}");

    p2 = DataPoint(
      userId:12,
      name: "Height",
      value: double.tryParse(heightController.text),
      collectionDate: DateTime.now().toString(),
      collectionType: 0
    );
    print("Weight: ${weightController.text}");

    bool? success1 = await ApiService().putData(12, p1);
    bool? success2 = await ApiService().putData(12, p2);

    if (success1! && success2!) {
      _showSuccessSnackBar("Data saved successfully.");
    } else {
      _showErrorSnackBar("Something went wrong (Server error)");
    }
    }
  }

  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Self Report"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Weight (lbs)',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),

            const SizedBox(height: 20),

            TextField(
              controller: heightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),

            const SizedBox(height: 20),
            
            GestureDetector(
              onTap: _saveData,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}