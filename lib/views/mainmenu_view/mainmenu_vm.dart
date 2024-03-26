// Mainmenu View Logic in here

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:jp_app/app/app.locator.dart';
import 'package:jp_app/app/app.router.dart';
import 'package:jp_app/services/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainMenuVM extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  Services services = locator<Services>();
  bool skipEstimation = false;
  String? service;

  init() async {
    final user = FirebaseAuth.instance.currentUser;
    log(user?.uid.toString() ?? 'null');
  }

  final imgList = [
    {
      'img':
          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'title': 'Car Service'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'title': 'Car Service'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'title': 'Car Service'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'title': 'Car Service'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'title': 'Car Service'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      'title': 'Car Service'
    },
  ];

  // checkData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   skipEstimation = prefs.getBool('skipEstimation') ?? skipEstimation;
  //   service = prefs.getString('serviceName')!;
  //   log(skipEstimation.toString());
  //   log(service.toString());
  //   notifyListeners();
  // }

  // fetchData() async {
  //   await checkData();
  // }

  setFalse() {
    dialogService
        .showConfirmationDialog(
      title: 'Logout',
      description: 'Are you sure you want to logout?',
      cancelTitle: 'No',
      confirmationTitle: 'Yes',
    )
        .then(
      (value) {
        if (value!.confirmed) {
          eraseData();
          log('erased');
          navigationService.replaceWithStartView();
        } else {
          log('not erased');
        }
      },
    );
  }

  navigateToEstimation(String serviceName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // log(service!);
    // log(serviceName);
    // log(skipEstimation.toString());
    // log(prefs.getString('serviceName') ?? 'null');
    // log(prefs.getBool('skipEstimation').toString() ??
    //     skipEstimation.toString());
    // log(prefs.getStringList('service').toString() ?? 'null');
    if (prefs.getStringList('service')!.contains(serviceName)) {
      navigationService.navigateToAppointmentView(service: serviceName);
    } else {
      navigationService.navigateToEstimationView(serviceName: serviceName);
    }
  }

  eraseData() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
    prefs.remove('documentID');
  }
}
