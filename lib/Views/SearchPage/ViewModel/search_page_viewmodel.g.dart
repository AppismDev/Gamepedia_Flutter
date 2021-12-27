// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageViewModel on _SearchPageViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_SearchPageViewModelBase.isLoading'))
          .value;

  final _$_isLoadingAtom = Atom(name: '_SearchPageViewModelBase._isLoading');

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  final _$isQueryFinishedAtom =
      Atom(name: '_SearchPageViewModelBase.isQueryFinished');

  @override
  bool get isQueryFinished {
    _$isQueryFinishedAtom.reportRead();
    return super.isQueryFinished;
  }

  @override
  set isQueryFinished(bool value) {
    _$isQueryFinishedAtom.reportWrite(value, super.isQueryFinished, () {
      super.isQueryFinished = value;
    });
  }

  final _$_SearchPageViewModelBaseActionController =
      ActionController(name: '_SearchPageViewModelBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_SearchPageViewModelBaseActionController.startAction(
        name: '_SearchPageViewModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_SearchPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchGames() {
    final _$actionInfo = _$_SearchPageViewModelBaseActionController.startAction(
        name: '_SearchPageViewModelBase.clearSearchGames');
    try {
      return super.clearSearchGames();
    } finally {
      _$_SearchPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isQueryFinished: ${isQueryFinished},
isLoading: ${isLoading}
    ''';
  }
}
