// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchPageViewModel on _SearchPageViewModelBase, Store {
  Computed<bool>? _$isShowHistoryComputed;

  @override
  bool get isShowHistory =>
      (_$isShowHistoryComputed ??= Computed<bool>(() => super.isShowHistory,
              name: '_SearchPageViewModelBase.isShowHistory'))
          .value;
  Computed<bool>? _$isShowDiscoverComputed;

  @override
  bool get isShowDiscover =>
      (_$isShowDiscoverComputed ??= Computed<bool>(() => super.isShowDiscover,
              name: '_SearchPageViewModelBase.isShowDiscover'))
          .value;
  Computed<bool>? _$loadingContentComputed;

  @override
  bool get loadingContent =>
      (_$loadingContentComputed ??= Computed<bool>(() => super.loadingContent,
              name: '_SearchPageViewModelBase.loadingContent'))
          .value;

  final _$_isShowHistoryAtom =
      Atom(name: '_SearchPageViewModelBase._isShowHistory');

  @override
  bool get _isShowHistory {
    _$_isShowHistoryAtom.reportRead();
    return super._isShowHistory;
  }

  @override
  set _isShowHistory(bool value) {
    _$_isShowHistoryAtom.reportWrite(value, super._isShowHistory, () {
      super._isShowHistory = value;
    });
  }

  final _$_isShowDiscoverAtom =
      Atom(name: '_SearchPageViewModelBase._isShowDiscover');

  @override
  bool get _isShowDiscover {
    _$_isShowDiscoverAtom.reportRead();
    return super._isShowDiscover;
  }

  @override
  set _isShowDiscover(bool value) {
    _$_isShowDiscoverAtom.reportWrite(value, super._isShowDiscover, () {
      super._isShowDiscover = value;
    });
  }

  final _$searchTextAtom = Atom(name: '_SearchPageViewModelBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$_loadingContentAtom =
      Atom(name: '_SearchPageViewModelBase._loadingContent');

  @override
  bool get _loadingContent {
    _$_loadingContentAtom.reportRead();
    return super._loadingContent;
  }

  @override
  set _loadingContent(bool value) {
    _$_loadingContentAtom.reportWrite(value, super._loadingContent, () {
      super._loadingContent = value;
    });
  }

  final _$searchedGamesAtom =
      Atom(name: '_SearchPageViewModelBase.searchedGames');

  @override
  ObservableList<GameModel> get searchedGames {
    _$searchedGamesAtom.reportRead();
    return super.searchedGames;
  }

  @override
  set searchedGames(ObservableList<GameModel> value) {
    _$searchedGamesAtom.reportWrite(value, super.searchedGames, () {
      super.searchedGames = value;
    });
  }

  final _$searchGameAsyncAction =
      AsyncAction('_SearchPageViewModelBase.searchGame');

  @override
  Future<void> searchGame() {
    return _$searchGameAsyncAction.run(() => super.searchGame());
  }

  final _$_SearchPageViewModelBaseActionController =
      ActionController(name: '_SearchPageViewModelBase');

  @override
  void setIsShowHistory(bool value) {
    final _$actionInfo = _$_SearchPageViewModelBaseActionController.startAction(
        name: '_SearchPageViewModelBase.setIsShowHistory');
    try {
      return super.setIsShowHistory(value);
    } finally {
      _$_SearchPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String value) {
    final _$actionInfo = _$_SearchPageViewModelBaseActionController.startAction(
        name: '_SearchPageViewModelBase.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_SearchPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
searchedGames: ${searchedGames},
isShowHistory: ${isShowHistory},
isShowDiscover: ${isShowDiscover},
loadingContent: ${loadingContent}
    ''';
  }
}
