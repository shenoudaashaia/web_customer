import 'package:flutter/material.dart';
import 'package:web_customer/ConfirmationPage.dart';
import 'package:web_customer/SurveyViewModel.dart';




Widget buildStyledQuestion(String questionText, Widget child) {
  
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        questionText,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      child,
    ],
  );
}

Widget buildNameQuestion(
  BuildContext context,
  SurveyViewModel viewModel,
  TextEditingController nameController,
) {
  return buildStyledQuestion(
    "1➜ What is your name? *",
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Enter your name",
            errorText: viewModel.nameError,
            errorStyle: TextStyle(color: Colors.red),
          ),
          onChanged: (value) => viewModel.setName(value),
        ),
      ],
    ),
  );
}





Widget buildPhoneQuestion(
  BuildContext context,
  SurveyViewModel viewModel,
  TextEditingController phoneController,
) {
  return buildStyledQuestion(
    "2➜ What is your phone number? *",
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1.5),
                ),
              ),
              child: DropdownButtonHideUnderline(
                
                child:DropdownButton<String>(
  value: viewModel.countryCode,
  onChanged: (String? newValue) {
    if (newValue != null) {
      viewModel.setCountryCode(newValue);
      // تحديث حقل الهاتف برمز الدولة
    }
  },
  items: viewModel.countryCodes.map<DropdownMenuItem<String>>((String code) {
    return DropdownMenuItem<String>(
      value: code,
      child: Row(
        children: [
          Image.network(
            viewModel.getFlagUrl(code), // استدعاء من viewModel
            width: 24,
            height: 16,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.flag),
          ),
          SizedBox(width: 8),
          Text(
            code,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }).toList(),
),



              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter your phone number",
                  errorText: viewModel.phoneError,
                  errorStyle: TextStyle(color: Colors.red),
                ),
                onChanged: (value) {
                  viewModel.setPhone(value);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildPhysiqueQuestion(BuildContext context, SurveyViewModel viewModel) {
  return buildStyledQuestion(
    "3➜ What best describes your physique? *",
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...viewModel.physiques.asMap().entries.map((entry) {
          String label = String.fromCharCode(65 + entry.key);
          String text = entry.value;
          return buildSelectableContainer(
            label: label,
            text: text,
            isSelected: viewModel.selectedPhysique == text,
            onTap: () => viewModel.setSelectedPhysique(text),
          );
        }).toList(),
        if (viewModel.physiqueError != null)
          Text(
            viewModel.physiqueError!,
            style: TextStyle(color: Colors.red),
          ),
      ],
    ),
  );
}


Widget buildFitnessGoalQuestion(
  BuildContext context,
  SurveyViewModel viewModel,
) {
  return buildStyledQuestion(
    "4➜ What is your primary fitness goal? *",
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...viewModel.fitnessGoals.asMap().entries.map((entry) {
          String label = String.fromCharCode(65 + entry.key);
          String text = entry.value;
          return buildSelectableContainer(
            label: label,
            text: text,
            isSelected: viewModel.selectedFitnessGoal == text,
            onTap: () => viewModel.setSelectedFitnessGoal(text),
          );
        }).toList(),
        if (viewModel.fitnessGoalError != null)
          Text(
            viewModel.fitnessGoalError!,
            style: TextStyle(color: Colors.red),
          ),
      ],
    ),
  );
}


Widget buildHelpOptionsQuestion(
  BuildContext context,
  SurveyViewModel viewModel,
) {
  return buildStyledQuestion(
    "5➜ What do you need help with? *",
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...viewModel.helpOptions.asMap().entries.map((entry) {
          String label = String.fromCharCode(65 + entry.key);
          String text = entry.value;
          return buildSelectableContainer(
            label: label,
            text: text,
            isSelected: viewModel.selectedHelpOptions.contains(text),
            onTap: () => viewModel.toggleHelpOption(
              text,
              !viewModel.selectedHelpOptions.contains(text),
            ),
          );
        }).toList(),
        if (viewModel.helpOptionsError != null)
          Text(
            viewModel.helpOptionsError!,
            style: TextStyle(color: Colors.red),
          ),
      ],
    ),
  );
}


Widget buildLocationQuestion(BuildContext context, SurveyViewModel viewModel) {
  return buildStyledQuestion(
    "6➜ Where are you located? *",
    Expanded(
      child: ListView(
        children: [
          ...viewModel.locations.asMap().entries.map((entry) {
            String label = String.fromCharCode(65 + entry.key);
            String text = entry.value;
            return buildSelectableContainer(
              label: label,
              text: text,
              isSelected: viewModel.selectedLocation == text,
              onTap: () => viewModel.setSelectedLocation(text),
            );
          }).toList(),
          // عرض رسالة الخطأ إذا لم يتم اختيار موقع
          if (viewModel.locationError != null)
            Text(
              viewModel.locationError!,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    ),
  );
}



Widget buildSelectableContainer({
  required String label,
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade300,
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buildNavigationButtons(BuildContext context, SurveyViewModel viewModel) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        if (viewModel.currentQuestionIndex > 0)
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: viewModel.previousQuestion,
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed:
                viewModel.currentQuestionIndex < 5
                    ? viewModel.nextQuestion
                    : () async {
                        bool success = await viewModel.submitData();
                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please select your location!"), // رسالة للمستخدم
                            ),
                          );
                          return;  // إذا كانت هناك مشكلة في اختيار الموقع، لا يتم الانتقال
                        }

                        // في حال نجاح الإرسال، نتوجه إلى صفحة التأكيد
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? "تم إرسال البيانات بنجاح!"
                                  : "حدث خطأ أثناء الإرسال",
                            ),
                          ),
                        );

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ConfirmationPage()),
                          );
                        }
                    },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}
