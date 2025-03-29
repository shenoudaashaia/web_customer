import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SurveyViewModel with ChangeNotifier {
  int _currentQuestionIndex = 0;
  String? _name;
  String? _phoneNumber;
  String? _selectedLocation;
  String? _selectedPhysique;
  String? _selectedFitnessGoal;
  String _countryCode = "+20";
  List<String> _selectedHelpOptions = [];

  String? nameError;
  String? phoneError;
  String? physiqueError;
  String? fitnessGoalError;
  String? helpOptionsError;
  String? locationError;

final List<String> countryCodes = [
  "+20", // مصر
  "+966", // السعودية
  "+971", // الإمارات
  "+973", // البحرين
  "+965", // الكويت
  "+968", // عمان
  "+974", // قطر
];


  final List<String> locations = [
    "Africa",
    "USA",
    "UK",
    "India",
    "Europe",
    "Canada",
    "Asia",
    "Australia",
    "Middle East",
    "South America",
    "Central America & Caribbean",
  ];

  final List<String> physiques = [
    "Skinny",
    "Skinny - Fat",
    "Overweight",
    "Muscle, with some fat",
    "Muscle, with lots of fat",
  ];

  final List<String> fitnessGoals = [
    "Lose Fat",
    "Gain Lean Muscle",
    "Improve Health and Longevity",
    "Improve Work and Productivity",
    "Get Beach Ready",
  ];

  final List<String> helpOptions = [
    "Staying Consistent (Accountability, Support & Motivation)",
    "How to workout properly to build Muscle",
    "Knowing how/what to Eat to Lose Fat",
    "Losing fat on a busy schedule",
    "Other (To be discussed further)",
  ];

  int get currentQuestionIndex => _currentQuestionIndex;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get selectedLocation => _selectedLocation;
  String? get selectedPhysique => _selectedPhysique;
  String get countryCode => _countryCode;
  String? get selectedFitnessGoal => _selectedFitnessGoal;
  List<String> get selectedHelpOptions => _selectedHelpOptions;

  final Map<String, RegExp> phoneRegexPatterns = {
    "+20": RegExp(r'^\d{10,11}$'),
    "+966": RegExp(r'^\d{9}$'),
    "+971": RegExp(r'^\d{9}$'),
    "+973": RegExp(r'^\d{8}$'),
    "+965": RegExp(r'^\d{8}$'),
    "+968": RegExp(r'^\d{8}$'),
    "+974": RegExp(r'^\d{8}$'),
  };

  String getFlagUrl(String countryCode) {
  final Map<String, String> flagUrls = {
    "+20": "https://flagcdn.com/w40/eg.png", // مصر
    "+966": "https://flagcdn.com/w40/sa.png", // السعودية
    "+971": "https://flagcdn.com/w40/ae.png", // الإمارات
    "+973": "https://flagcdn.com/w40/bh.png", // البحرين
    "+965": "https://flagcdn.com/w40/kw.png", // الكويت
    "+968": "https://flagcdn.com/w40/om.png", // عمان
    "+974": "https://flagcdn.com/w40/qa.png", // قطر
  };

  return flagUrls[countryCode] ?? "https://flagcdn.com/w40/un.png"; // علم افتراضي
}



  void setName(String value) {
    _name = value;
    validateName();
    notifyListeners();
  }

  void setCountryCode(String code) {
    _countryCode = code;
    validatePhone();
    notifyListeners();
  }

  void setPhone(String value) {
    _phoneNumber = value;
    validatePhone();
    notifyListeners();
  }

  void setSelectedLocation(String? value) {
    _selectedLocation = value;
    notifyListeners();
  }

  void setSelectedPhysique(String? value) {
    _selectedPhysique = value;
    notifyListeners();
  }

  void setSelectedFitnessGoal(String? value) {
    _selectedFitnessGoal = value;
    notifyListeners();
  }

  void toggleHelpOption(String option, bool isSelected) {
    if (isSelected) {
      _selectedHelpOptions.add(option);
    } else {
      _selectedHelpOptions.remove(option);
    }
    notifyListeners();
  }

  void validateName() {
    if (_name == null || _name!.trim().isEmpty) {
      nameError = "Please fill this in";
    } else if (_name!.length < 3) {
      nameError = "Name must be at least 3 characters";
    } else {
      nameError = null;
    }
  }

  void validatePhone() {
  if (_phoneNumber == null || _phoneNumber!.isEmpty) {
    phoneError = "Phone number cannot be empty";
  } else if (!phoneRegexPatterns.containsKey(_countryCode) ||
      !phoneRegexPatterns[_countryCode]!.hasMatch(_phoneNumber!)) {
    phoneError = "Invalid phone number for $_countryCode";
  } else {
    phoneError = null;
  }
  notifyListeners();
}


  void validatePhysique() {
    if (_selectedPhysique == null) {
      physiqueError = "Please select your physique";
    } else {
      physiqueError = null;
    }
  }

  void validateFitnessGoal() {
    if (_selectedFitnessGoal == null) {
      fitnessGoalError = "Please select your fitness goal";
    } else {
      fitnessGoalError = null;
    }
  }

  void validateHelpOptions() {
    if (_selectedHelpOptions.isEmpty) {
      helpOptionsError = "Please select at least one help option";
    } else {
      helpOptionsError = null;
    }
  }

  void validateLocation() {
    if (_selectedLocation == null) {
      locationError = "Please select your location";
    } else {
      locationError = null;
    }
  }

  void nextQuestion() {
    if (_currentQuestionIndex == 0) {
      validateName();
      if (nameError != null) {
        notifyListeners();
        return;
      }
    } else if (_currentQuestionIndex == 1) {
      validatePhone();
      if (phoneError != null) {
        notifyListeners();
        return;
      }
    } else if (_currentQuestionIndex == 2) {
      validatePhysique();
      if (physiqueError != null) {
        notifyListeners();
        return;
      }
    } else if (_currentQuestionIndex == 3) {
      validateFitnessGoal();
      if (fitnessGoalError != null) {
        notifyListeners();
        return;
      }
    } else if (_currentQuestionIndex == 4) {
      validateHelpOptions();
      if (helpOptionsError != null) {
        notifyListeners();
        return;
      }
    } else if (_currentQuestionIndex == 5) {
      validateLocation();
      if (locationError != null) {
        notifyListeners();
        return;
      }
    }

    if (_currentQuestionIndex < 5) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  Future<bool> submitData() async {
    if (_name == null ||
        _phoneNumber == null ||
        _selectedLocation == null ||
        _selectedPhysique == null ||
        _selectedFitnessGoal == null)
      return false;
    try {
      await FirebaseFirestore.instance.collection('survey_responses').add({
        'name': _name,
        'phone': _phoneNumber,
        'location': _selectedLocation,
        'physique': _selectedPhysique,
        'fitness_goal': _selectedFitnessGoal,
        'help_options': _selectedHelpOptions,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print("Error submitting data: $e");
      return false;
    }
  }
}
