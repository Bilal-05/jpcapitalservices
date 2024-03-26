// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_mailer/flutter_mailer.dart';
// import 'package:stacked_services/stacked_services.dart';

// class SendMail extends StatefulWidget {
//   final String description;
//   final String name;
//   final String email;
//   final String service;
//   final List<String> attachments;
//   const SendMail(
//       {super.key,
//       required this.description,
//       required this.name,
//       required this.email,
//       required this.service,
//       required this.attachments});

//   @override
//   State<SendMail> createState() => _SendMailState();
// }

// class _SendMailState extends State<SendMail> {
//   Future<void> send(BuildContext context) async {
//     if (Platform.isIOS) {
//       final bool canSend = await FlutterMailer.canSendMail();
//       if (!canSend) {
//         SnackbarService().showSnackbar(
//             message: 'No Email App Available',
//             title: 'Error',
//             duration: const Duration(seconds: 1));
//         return;
//       }
//     }

//     // Platform messages may fail, so we use a try/catch PlatformException.
//     final MailOptions mailOptions = MailOptions(
//       body:
//           'Hey JP, \n${widget.description} \n\nRegards, \n${widget.name} \n${widget.email}',
//       subject: '${widget.service} service required',
//       recipients: ["mamudrama@gmail.com"],
//       isHTML: false,
//       // bccRecipients: ['other@example.com'],
//       // ccRecipients: <String>['third@example.com'],
//       attachments: widget.attachments,
//     );

//     String platformResponse;

//     try {
//       final MailerResponse response = await FlutterMailer.send(mailOptions);
//       switch (response) {
//         case MailerResponse.saved:
//           platformResponse = 'mail was saved to draft';
//           break;
//         case MailerResponse.sent:
//           platformResponse = 'mail was sent';
//           break;
//         case MailerResponse.cancelled:
//           platformResponse = 'mail was cancelled';
//           break;
//         case MailerResponse.android:
//           platformResponse = 'intent was success';
//           break;
//         default:
//           platformResponse = 'unknown';
//           break;
//       }
//     } on PlatformException catch (error) {
//       platformResponse = error.toString();
//       print(error);
//       if (mounted == false) {
//         return;
//       }
//       // ignore: use_build_context_synchronously
//       await showDialog<void>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 'Message',
//                 style: Theme.of(context).textTheme.subtitle1,
//               ),
//               Text(error.message ?? 'unknown error'),
//             ],
//           ),
//           contentPadding: const EdgeInsets.all(26),
//           title: Text(error.code),
//         ),
//       );
//     } catch (error) {
//       platformResponse = error.toString();
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(platformResponse),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
