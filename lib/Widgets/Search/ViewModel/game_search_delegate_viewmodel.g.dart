// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_search_delegate_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameSearchDelegateViewModel on _GameSearchDelegateViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_GameSearchDelegateViewModelBase.isLoading'))
          .value;

  final _$_isLoadingAtom =
      Atom(name: '_GameSearchDelegateViewModelBase._isLoading');

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
      Atom(name: '_GameSearchDelegateViewModelBase.isQueryFinished');

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

  final _$_GameSearchDelegateViewModelBaseActionController =
      ActionController(name: '_GameSearchDelegateViewModelBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_GameSearchDelegateViewModelBaseActionController
        .startAction(name: '_GameSearchDelegateViewModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_GameSearchDelegateViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchGames() {
    final _$actionInfo = _$_GameSearchDelegateViewModelBaseActionController
        .startAction(name: '_GameSearchDelegateViewModelBase.clearSearchGames');
    try {
      return super.clearSearchGames();
    } finally {
      _$_GameSearchDelegateViewModelBaseActionController
          .endAction(_$actionInfo);
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
