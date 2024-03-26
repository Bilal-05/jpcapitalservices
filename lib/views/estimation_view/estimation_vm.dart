//  Estimation View Logic in here

import 'dart:io';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
// import 'package:jp_app/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EstimationVM extends BaseViewModel {
  TextEditingController serviceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final NavigationService navigationService = locator<NavigationService>();
  final formKey = GlobalKey<FormState>();
  final dialogService = locator<DialogService>();
  File? imageAdded;
  List<File> images = [];
  List<String> attachments = [];
  String? service;

  ImagePicker imagePicker = ImagePicker();

  init(serviceName) {
    final user = FirebaseAuth.instance.currentUser;
    // GoogleSignIn googleSignIn = GoogleSignIn();
    serviceController.text = 'Service: $serviceName';
    service = serviceName;
    if (user != null) {
      emailController.text = user.email!;
    }
    // nameController.text = user!.displayName!;
    notifyListeners();
  }

  removeAt(index) {
    dialogService
        .showConfirmationDialog(
            title: 'Remove Photo',
            description: 'Are you sure?',
            cancelTitle: 'No',
            confirmationTitle: 'Yes')
        .then((value) {
      if (value!.confirmed) {
        images.removeAt(index);
        notifyListeners();
        log('erased');
      } else {
        log('not erased');
      }
    });
  }

  setValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final serviceList = prefs.getStringList('service') ?? [];
    await prefs.setStringList('service', serviceList..add(service!));
    notifyListeners();
    log(prefs.getStringList('service').toString());

    notifyListeners();
  }

  addPhoto() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (image != null) {
      imageAdded = File(image.path);
      images.add(imageAdded!);
      attachments.add(image.path);
      notifyListeners();
    }
  }

  navigateToAppointmentView() async {
    if (formKey.currentState!.validate()) {
      await sendFlutterEmail();
      navigationService.navigateToAppointmentView(service: service!);
    } else {
      SnackbarService().showSnackbar(
          message: 'Fill all fields',
          title: 'Error',
          duration: const Duration(seconds: 1));
    }
  }

  Future<void> sendFlutterEmail() async {
    final Email email = Email(
      body:
          'Hey JP, \n${descriptionController.text} \n\nRegards, \n${nameController.text} \n${emailController.text}',
      subject: '${serviceController.text} required',
      recipients: ["mamudrama@gmail.com"],
      attachmentPaths: attachments,
      // isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      // FlutterEmailSender.s
      await setValues();
      platformResponse = 'success';
      navigationService.replaceWithAppointmentView(service: service!);
    } catch (error) {
      print(error);
      platformResponse = error.toString();
      SnackbarService().showSnackbar(
        message: error.toString(),
        title: 'Error',
        duration: const Duration(seconds: 1),
      );
      log(error.toString());
    }

    SnackbarService().showSnackbar(
      message: platformResponse,
      title: 'Success',
      duration: const Duration(seconds: 1),
    );
  }

  // Future onSubmit() async {
  //   log('in');

  //   final user = await GoogleAuthApi.signIn();

  //   if (user == null) return log('user is null');

  //   final email = user.email;
  //   final auth = await user.authentication;
  //   final token = auth.accessToken;

  //   log('middle');

  //   final smtpServer = gmailSaslXoauth2(email, token!);
  //   final messageEmail = Message()
  //     ..from = Address(email, nameController.text.toString())
  //     ..recipients.add(const Address('mamudrama@gmail.com'))
  //     // ..ccRecipients
  //     //     .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  //     // ..bccRecipients.add('bccAddress@example.com')
  //     ..subject = '${service!} required'
  //     ..text =
  //         'Hey JP, \n\n${descriptionController.text} \n\nRegards, \n${nameController.text} \n${emailController.text}';
  //   // ..attachments = [
  //   //   for (var image in images)
  //   //     FileAttachment(
  //   //       File(image.path),
  //   //     )
  //   //       ..location = Location.inline
  //   //       ..cid = '<${image.path}.141>',
  //   // ];

  //   try {
  //     await send(messageEmail, smtpServer);
  //     SnackbarService().showSnackbar(
  //       message: 'Email sent successfully',
  //       title: 'Success',
  //       duration: const Duration(seconds: 1),
  //     );
  //   } on MailerException catch (e) {
  //     log(e.toString());
  //   }
  //   log('ended');
  // }

  // Future onSubmit() async {
  //   log('in');

  //   final user = await GoogleAuthApi.signIn();

  //   if (user == null) return log('user is null');

  //   final email = user.email;
  //   final auth = await user.authentication;
  //   final token = auth.accessToken;

  //   log('middle');

  //   final smtpServer = gmailSaslXoauth2(email, token!);
  //   final message = Message()
  //     ..from = Address(email, nameController.text.toString())
  //     ..recipients.add(const Address('mamudrama@gmail.com'))
  //     // ..ccRecipients
  //     //     .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
  //     // ..bccRecipients.add('bccAddress@example.com')
  //     ..subject = '${serviceController.text} required}'
  //     ..text =
  //         'Hey JP, \n${descriptionController.text} \n\nRegards, \n${nameController.text} \n${emailController.text}}'
  //     // ..html =
  //     //     '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
  //     ..attachments = [
  //       FileAttachment(
  //         File(images[0].path),
  //       )
  //         ..location = Location.inline
  //         ..cid = '<myimg@3.141>',
  //     ];
  //   log('end');

  //   try {
  //     await send(message, smtpServer);
  //     SnackbarService().showSnackbar(
  //       message: 'Email sent successfully',
  //       title: 'Success',
  //       duration: const Duration(seconds: 1),
  //     );
  //   } on MailerException catch (e) {
  //     print(e);
  //   }
  //   log('ended');
  // }
}


// class EmailSender extends StatefulWidget {
//   const EmailSender({Key? key}) : super(key: key);

//   @override
//   _EmailSenderState createState() => _EmailSenderState();
// }

// class _EmailSenderState extends State<EmailSender> {
//   List<String> attachments = [];
//   bool isHTML = false;

//   final _recipientController = TextEditingController(
//     text: 'example@example.com',
//   );

//   final _subjectController = TextEditingController(text: 'The subject');

//   final _bodyController = TextEditingController(
//     text: 'Mail body.',
//   );

//   Future<void> send() async {
//     final Email email = Email(
//       body: _bodyController.text,
//       subject: _subjectController.text,
//       recipients: [_recipientController.text],
//       attachmentPaths: attachments,
//       isHTML: isHTML,
//     );

//     String platformResponse;

//     try {
//       await FlutterEmailSender.send(email);
//       platformResponse = 'success';
//     } catch (error) {
//       print(error);
//       platformResponse = error.toString();
//     }

//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(platformResponse),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plugin example app'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: send,
//             icon: Icon(Icons.send),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _recipientController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Recipient',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _subjectController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Subject',
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _bodyController,
//                   maxLines: null,
//                   expands: true,
//                   textAlignVertical: TextAlignVertical.top,
//                   decoration: InputDecoration(
//                       labelText: 'Body', border: OutlineInputBorder()),
//                 ),
//               ),
//             ),
//             CheckboxListTile(
//               contentPadding:
//                   EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//               title: Text('HTML'),
//               onChanged: (bool? value) {
//                 if (value != null) {
//                   setState(() {
//                     isHTML = value;
//                   });
//                 }
//               },
//               value: isHTML,
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Column(
//                 children: <Widget>[
//                   for (var i = 0; i < attachments.length; i++)
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: Text(
//                             attachments[i],
//                             softWrap: false,
//                             overflow: TextOverflow.fade,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.remove_circle),
//                           onPressed: () => {_removeAttachment(i)},
//                         )
//                       ],
//                     ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: IconButton(
//                       icon: Icon(Icons.attach_file),
//                       onPressed: _openImagePicker,
//                     ),
//                   ),
//                   TextButton(
//                     child: Text('Attach file in app documents directory'),
//                     onPressed: () => _attachFileFromAppDocumentsDirectoy(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _openImagePicker() async {
//     final picker = ImagePicker();
//     XFile? pick = await picker.pickImage(source: ImageSource.camera);
//     PickedFile pickedFile = PickedFile(pick!.path);
//     if (pick != null) {
//       setState(() {
//         attachments.add(pick.path);
//       });
//     }
//   }

//   void _removeAttachment(int index) {
//     setState(() {
//       attachments.removeAt(index);
//     });
//   }

//   Future<void> _attachFileFromAppDocumentsDirectoy() async {
//     try {
//       final appDocumentDir = await getApplicationDocumentsDirectory();
//       final filePath = appDocumentDir.path + '/file.txt';
//       final file = File(filePath);
//       await file.writeAsString('Text file in app directory');

//       setState(() {
//         attachments.add(filePath);
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to create file in applicion directory'),
//         ),
//       );
//     }
//   }
// }

