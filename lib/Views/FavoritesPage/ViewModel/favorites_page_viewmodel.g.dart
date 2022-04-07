// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesPageViewModel on _FavoritesPageViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_FavoritesPageViewModelBase.isLoading'))
          .value;

  final _$_isLoadingAtom = Atom(name: '_FavoritesPageViewModelBase._isLoading');

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

  final _$favoriteGamesAtom =
      Atom(name: '_FavoritesPageViewModelBase.favoriteGames');

  @override
  ObservableList<GameModel>? get favoriteGames {
    _$favoriteGamesAtom.reportRead();
    return super.favoriteGames;
  }

  @override
  set favoriteGames(ObservableList<GameModel>? value) {
    _$favoriteGamesAtom.reportWrite(value, super.favoriteGames, () {
      super.favoriteGames = value;
    });
  }

  final _$_FavoritesPageViewModelBaseActionController =
      ActionController(name: '_FavoritesPageViewModelBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_FavoritesPageViewModelBaseActionController
        .startAction(name: '_FavoritesPageViewModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_FavoritesPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteGames: ${favoriteGames},
isLoading: ${isLoading}
    ''';
  }
}
