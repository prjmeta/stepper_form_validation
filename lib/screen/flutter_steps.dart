import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlutterSteps extends StatefulWidget {
  const FlutterSteps({Key? key}) : super(key: key);

  @override
  State<FlutterSteps> createState() => _FlutterStepsState();
}

class _FlutterStepsState extends State<FlutterSteps> {
  int currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  final formKey =
      GlobalKey<FormState>(); //form object to be used for form validation

  //sender details
  final senderName = TextEditingController();
  final senderAddress = TextEditingController();

  //receiver details
  final receiverName = TextEditingController();
  final receiverAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Steps'),
      ),
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.teal)),
        child: Form(
          key: formKey,
          child: Stepper(
            steps: getSteps(),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepTapped: (step) {
              formKey.currentState!.validate(); //this will trigger validation
              setState(() {
                currentStep = step;
              });
            },
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              formKey.currentState!.validate();
              bool isDetailValid =
                  isDetailComplete(); //this check if ok to move on to next screen

              if (isDetailValid) {
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                  });
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
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
        ),
      ),
    );
  }

  bool isDetailComplete() {
    if (currentStep == 0) {
      //check sender fields
      if (senderName.text.isEmpty || senderAddress.text.isEmpty) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (currentStep == 1) {
      //check receiver fields
      if (receiverName.text.isEmpty || receiverAddress.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
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
                  controller: senderName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Sender Address'),
                  controller: senderAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required.";
                    }
                    return null;
                  },
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
                  controller: receiverName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Receiver Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required.";
                    }
                    return null;
                  },
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
