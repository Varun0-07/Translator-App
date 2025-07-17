import 'package:Translator/historyPage.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart'; // Import the translator package

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // ignore: non_constant_identifier_names
  var Languages = [
    "English",
    "Hindi",
    "Sanskrit",
    "Urdu",
    "French",
    "Spanish",
    "German",
    "Arabic",
    "Japanese",
    "Russian",
    "Chinese",
    "Indonesian",
    "Italian",
    "Portuguese",
    "Turkish",
    "Korean",
    "Dutch",
    "Swedish",
    "Norwegian",
    "Danish",
    "Finnish",
    "Polish",
  ];
  var originlanguage = "From";
  var targetlanguage = "To";
  var output = "";
  TextEditingController inputController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {
      setState(() {
        output = "Please select both source and target languages.";
      });
    }

    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    // This function will handle the translation logic
    // For now, we will just set the output to the input text
    setState(() {
      output = translation.text.toString();
      // Add the translation to history
      translationHistory.add(
        "From $originlanguage to $targetlanguage: $translation",
      );
    });

    if (translationHistory.length > 10) {
      translationHistory.removeAt(0); // Keep only the last 10 translations
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case "English":
        return "en";
      case "Hindi":
        return "hi";
      case "Sanskrit":
        return "sa";
      case "Urdu":
        return "ur";
      case "French":
        return "fr";
      case "Spanish":
        return "es";
      case "German":
        return "de";
      case "Arabic":
        return "ar";
      case "Japanese":
        return "ja";
      case "Russian":
        return "ru";
      case "Chinese":
        return "zh-CHS";
      case "Indonesian":
        return "id";
      case "Italian":
        return "it";
      case "Portuguese":
        return "pt";
      case "Turkish":
        return "tr";
      case "Korean":
        return "ko";
      case "Dutch":
        return "nl";
      case "Swedish":
        return "sv";
      case "Norwegian":
        return "no";
      case "Danish":
        return "da";
      case "Finnish":
        return "fi";
      case "Polish":
        return "pl";
      default:
        return "--"; // Default case if no match found
    }
  }

  // List to keep track of translation history
  List<String> translationHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(64, 45, 150, 192),
      appBar: AppBar(
        title: Text(
          "Language Translator",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        // centerTitle: true,
        backgroundColor: const Color.fromARGB(150, 42, 158, 158),
        elevation: 100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              // Navigate to history page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => HistoryPage(history: translationHistory),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.green,
                    iconDisabledColor: const Color.fromARGB(123, 7, 3, 15),
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originlanguage,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    dropdownColor: Colors.black,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:
                        Languages.map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValueSelected) {
                      setState(() {
                        originlanguage = newValueSelected!;
                      });
                    },
                  ),
                  // arrow icon to indicate direction
                  SizedBox(width: 40),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 40),
                  SizedBox(width: 40),
                  // to select target language
                  DropdownButton(
                    focusColor: Colors.green,
                    iconDisabledColor: Colors.brown,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      targetlanguage,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    dropdownColor: Colors.black,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:
                        Languages.map((String dropDownStringItem) {
                          return DropdownMenuItem(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValueSelected) {
                      setState(() {
                        targetlanguage = newValueSelected!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Enter text to translate",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  controller: inputController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              // to give gap btween text field and button
              SizedBox(height: 60),
              // button to translate the text
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(131, 31, 70, 92),
                  ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originlanguage),
                      getLanguageCode(targetlanguage),
                      inputController.text.toString(),
                    );
                  },
                  child: Text(
                    'Translate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // to give gap btween button and output text
              SizedBox(height: 20),
              // to show the output of translation
              Text(
                '\nOutput:',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                output,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
