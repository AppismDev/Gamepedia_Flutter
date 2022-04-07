// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre_filter_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GenreFilterPageViewModel on _GenreFilterPageViewModelBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_GenreFilterPageViewModelBase.isLoading'))
          .value;
  Computed<bool>? _$isPaginationLoadingComputed;

  @override
  bool get isPaginationLoading => (_$isPaginationLoadingComputed ??=
          Computed<bool>(() => super.isPaginationLoading,
              name: '_GenreFilterPageViewModelBase.isPaginationLoading'))
      .value;

  final _$_isLoadingAtom =
      Atom(name: '_GenreFilterPageViewModelBase._isLoading');

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

  final _$_isPaginationLoadingAtom =
      Atom(name: '_GenreFilterPageViewModelBase._isPaginationLoading');

  @override
  bool get _isPaginationLoading {
    _$_isPaginationLoadingAtom.reportRead();
    return super._isPaginationLoading;
  }

  @override
  set _isPaginationLoading(bool value) {
    _$_isPaginationLoadingAtom.reportWrite(value, super._isPaginationLoading,
        () {
      super._isPaginationLoading = value;
    });
  }

  final _$genreFilteredGamesAtom =
      Atom(name: '_GenreFilterPageViewModelBase.genreFilteredGames');

  @override
  ObservableList<GameModel?> get genreFilteredGames {
    _$genreFilteredGamesAtom.reportRead();
    return super.genreFilteredGames;
  }

  @override
  set genreFilteredGames(ObservableList<GameModel?> value) {
    _$genreFilteredGamesAtom.reportWrite(value, super.genreFilteredGames, () {
      super.genreFilteredGames = value;
    });
  }

  final _$getFilteredGamesAsyncAction =
      AsyncAction('_GenreFilterPageViewModelBase.getFilteredGames');

  @override
  Future<void> getFilteredGames(List<GenreLiteModel?> genres) {
    return _$getFilteredGamesAsyncAction
        .run(() => super.getFilteredGames(genres));
  }

  final _$getFilteredGamesPaginationAsyncAction =
      AsyncAction('_GenreFilterPageViewModelBase.getFilteredGamesPagination');

  @override
  Future<void> getFilteredGamesPagination(List<GenreLiteModel?> genres) {
    return _$getFilteredGamesPaginationAsyncAction
        .run(() => super.getFilteredGamesPagination(genres));
  }

  final _$_GenreFilterPageViewModelBaseActionController =
      ActionController(name: '_GenreFilterPageViewModelBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_GenreFilterPageViewModelBaseActionController
        .startAction(name: '_GenreFilterPageViewModelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_GenreFilterPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsPaginationLoading(bool value) {
    final _$actionInfo =
        _$_GenreFilterPageViewModelBaseActionController.startAction(
            name: '_GenreFilterPageViewModelBase.setIsPaginationLoading');
    try {
      return super.setIsPaginationLoading(value);
    } finally {
      _$_GenreFilterPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
genreFilteredGames: ${genreFilteredGames},
isLoading: ${isLoading},
isPaginationLoading: ${isPaginationLoading}
    ''';
  }
}
