import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_page_viewmodel.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {

  final controller = PageController(viewportFraction: 0.9);



  @observable
  int currentIndex = 0;

  @action
  void setCurrentIndex(int index) => currentIndex = index;
}
