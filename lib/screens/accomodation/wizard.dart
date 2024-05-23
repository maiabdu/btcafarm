// import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Switch Wizard',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SwitchWizard(),
//     );
//   }
// }

// class SwitchWizard extends StatefulWidget {
//   @override
//   _SwitchWizardState createState() => _SwitchWizardState();
// }

// class _SwitchWizardState extends State<SwitchWizard> {
//   int _currentStep = 0;
//   List<Step> _steps = [
//     Step(
//       title: Text('Step 1'),
//       content: Text('This is the content of step 1.'),
//     ),
//     Step(
//       title: Text('Step 2'),
//       content: Text('This is the content of step 2.'),
//     ),
//     Step(
//       title: Text('Step 3'),
//       content: Text('This is the content of step 3.'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Switch Wizard'),
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         steps: _steps,
//         onStepContinue: () {
//           setState(() {
//             if (_currentStep < _steps.length - 1) {
//               _currentStep++;
//             }
//           });
//         },
//         onStepCancel: () {
//           setState(() {
//             if (_currentStep > 0) {
//               _currentStep--;
//             }
//           });
//         },
//         controlsBuilder: (BuildContext context,
//             {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
//           return Row(
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: onStepContinue,
//                 child: Text('Next'),
//               ),
//               SizedBox(width: 16.0),
//               TextButton(
//                 onPressed: onStepCancel,
//                 child: Text('Back'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
