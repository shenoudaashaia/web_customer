import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_customer/SurveyViewModel.dart';

import 'package:web_customer/widget/survey_widgets.dart';

class SurveyScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<SurveyViewModel>(
                builder: (context, viewModel, child) {
                  return Center(
                    child: _buildQuestion(context, viewModel),
                  );
                },
              ),
            ),
          ),
          Consumer<SurveyViewModel>(
            builder: (context, viewModel, child) {
              return buildNavigationButtons(context, viewModel);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, SurveyViewModel viewModel) {
    switch (viewModel.currentQuestionIndex) {
      case 0:
        return buildNameQuestion(context, viewModel, _nameController);
      case 1:
        return buildPhoneQuestion(context, viewModel, _phoneController);
      case 2:
        return buildPhysiqueQuestion(context, viewModel);
      case 3:
        return buildFitnessGoalQuestion(context, viewModel);
      case 4:
        return buildHelpOptionsQuestion(context, viewModel);
      case 5:
        return buildLocationQuestion(context, viewModel);
      default:
        return SizedBox.shrink();
    }
  }
}
