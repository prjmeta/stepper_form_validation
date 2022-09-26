import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterSteps extends StatefulWidget {
  const FlutterSteps({Key? key}) : super(key: key);

  @override
  State<FlutterSteps> createState() => _FlutterStepsState();
}

class _FlutterStepsState extends State<FlutterSteps> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Steps'),
      ),
      body: Stepper(
        steps: getSteps(),
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepTapped: (step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (!isLastStep) {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (currentStep == 0) {
            null;
          } else {
            setState(() {
              currentStep -= 1;
            });
          }
        },
      ),
    );
  }

  //This will be your screens
  List<Step> getSteps() => [
        Step(
            title: const Text('Sender'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Sender Name'),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Sender Address'),
                ),
              ],
            )),
        Step(
            title: const Text('Receiver'),
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Receiver Name'),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Receiver Address'),
                ),
              ],
            )),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Complete'),
          content: Column(
            children: const [Text('Information Complete!')],
          ),
        )
      ];
}
