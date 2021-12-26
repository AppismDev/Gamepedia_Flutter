// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  Computed<bool>? _$loadingBestOfAllYearGamesComputed;

  @override
  bool get loadingBestOfAllYearGames => (_$loadingBestOfAllYearGamesComputed ??=
          Computed<bool>(() => super.loadingBestOfAllYearGames,
              name: '_HomePageViewModelBase.loadingBestOfAllYearGames'))
      .value;
  Computed<bool>? _$loadingBestOfLastMonthsComputed;

  @override
  bool get loadingBestOfLastMonths => (_$loadingBestOfLastMonthsComputed ??=
          Computed<bool>(() => super.loadingBestOfLastMonths,
              name: '_HomePageViewModelBase.loadingBestOfLastMonths'))
      .value;
  Computed<bool>? _$loadingBestOfLastYearComputed;

  @override
  bool get loadingBestOfLastYear => (_$loadingBestOfLastYearComputed ??=
          Computed<bool>(() => super.loadingBestOfLastYear,
              name: '_HomePageViewModelBase.loadingBestOfLastYear'))
      .value;
  Computed<bool>? _$loadingAllGenresComputed;

  @override
  bool get loadingAllGenres => (_$loadingAllGenresComputed ??= Computed<bool>(
          () => super.loadingAllGenres,
          name: '_HomePageViewModelBase.loadingAllGenres'))
      .value;
  Computed<bool>? _$loadingAllThemesComputed;

  @override
  bool get loadingAllThemes => (_$loadingAllThemesComputed ??= Computed<bool>(
          () => super.loadingAllThemes,
          name: '_HomePageViewModelBase.loadingAllThemes'))
      .value;

  final _$bestOfAllYearGamesAtom =
      Atom(name: '_HomePageViewModelBase.bestOfAllYearGames');

  @override
  ObservableList<GameModel?> get bestOfAllYearGames {
    _$bestOfAllYearGamesAtom.reportRead();
    return super.bestOfAllYearGames;
  }

  @override
  set bestOfAllYearGames(ObservableList<GameModel?> value) {
    _$bestOfAllYearGamesAtom.reportWrite(value, super.bestOfAllYearGames, () {
      super.bestOfAllYearGames = value;
    });
  }

  final _$_loadingBestOfAllYearGamesAtom =
      Atom(name: '_HomePageViewModelBase._loadingBestOfAllYearGames');

  @override
  bool get _loadingBestOfAllYearGames {
    _$_loadingBestOfAllYearGamesAtom.reportRead();
    return super._loadingBestOfAllYearGames;
  }

  @override
  set _loadingBestOfAllYearGames(bool value) {
    _$_loadingBestOfAllYearGamesAtom
        .reportWrite(value, super._loadingBestOfAllYearGames, () {
      super._loadingBestOfAllYearGames = value;
    });
  }

  final _$bestOfLastMonthsAtom =
      Atom(name: '_HomePageViewModelBase.bestOfLastMonths');

  @override
  ObservableList<GameModel?> get bestOfLastMonths {
    _$bestOfLastMonthsAtom.reportRead();
    return super.bestOfLastMonths;
  }

  @override
  set bestOfLastMonths(ObservableList<GameModel?> value) {
    _$bestOfLastMonthsAtom.reportWrite(value, super.bestOfLastMonths, () {
      super.bestOfLastMonths = value;
    });
  }

  final _$_loadingBestOfLastMonthsAtom =
      Atom(name: '_HomePageViewModelBase._loadingBestOfLastMonths');

  @override
  bool get _loadingBestOfLastMonths {
    _$_loadingBestOfLastMonthsAtom.reportRead();
    return super._loadingBestOfLastMonths;
  }

  @override
  set _loadingBestOfLastMonths(bool value) {
    _$_loadingBestOfLastMonthsAtom
        .reportWrite(value, super._loadingBestOfLastMonths, () {
      super._loadingBestOfLastMonths = value;
    });
  }

  final _$bestOfLastYearAtom =
      Atom(name: '_HomePageViewModelBase.bestOfLastYear');

  @override
  ObservableList<GameModel?> get bestOfLastYear {
    _$bestOfLastYearAtom.reportRead();
    return super.bestOfLastYear;
  }

  @override
  set bestOfLastYear(ObservableList<GameModel?> value) {
    _$bestOfLastYearAtom.reportWrite(value, super.bestOfLastYear, () {
      super.bestOfLastYear = value;
    });
  }

  final _$_loadingBestOfLastYearAtom =
      Atom(name: '_HomePageViewModelBase._loadingBestOfLastYear');

  @override
  bool get _loadingBestOfLastYear {
    _$_loadingBestOfLastYearAtom.reportRead();
    return super._loadingBestOfLastYear;
  }

  @override
  set _loadingBestOfLastYear(bool value) {
    _$_loadingBestOfLastYearAtom
        .reportWrite(value, super._loadingBestOfLastYear, () {
      super._loadingBestOfLastYear = value;
    });
  }

  final _$allGenresAtom = Atom(name: '_HomePageViewModelBase.allGenres');

  @override
  ObservableList<GenreLiteModel?> get allGenres {
    _$allGenresAtom.reportRead();
    return super.allGenres;
  }

  @override
  set allGenres(ObservableList<GenreLiteModel?> value) {
    _$allGenresAtom.reportWrite(value, super.allGenres, () {
      super.allGenres = value;
    });
  }

  final _$_loadingAllGenresAtom =
      Atom(name: '_HomePageViewModelBase._loadingAllGenres');

  @override
  bool get _loadingAllGenres {
    _$_loadingAllGenresAtom.reportRead();
    return super._loadingAllGenres;
  }

  @override
  set _loadingAllGenres(bool value) {
    _$_loadingAllGenresAtom.reportWrite(value, super._loadingAllGenres, () {
      super._loadingAllGenres = value;
    });
  }

  final _$allThemesAtom = Atom(name: '_HomePageViewModelBase.allThemes');

  @override
  ObservableList<ThemeModel?> get allThemes {
    _$allThemesAtom.reportRead();
    return super.allThemes;
  }

  @override
  set allThemes(ObservableList<ThemeModel?> value) {
    _$allThemesAtom.reportWrite(value, super.allThemes, () {
      super.allThemes = value;
    });
  }

  final _$_loadingAllThemesAtom =
      Atom(name: '_HomePageViewModelBase._loadingAllThemes');

  @override
  bool get _loadingAllThemes {
    _$_loadingAllThemesAtom.reportRead();
    return super._loadingAllThemes;
  }

  @override
  set _loadingAllThemes(bool value) {
    _$_loadingAllThemesAtom.reportWrite(value, super._loadingAllThemes, () {
      super._loadingAllThemes = value;
    });
  }

  final _$getBestOfAllYearGamesAsyncAction =
      AsyncAction('_HomePageViewModelBase.getBestOfAllYearGames');

  @override
  Future<void> getBestOfAllYearGames() {
    return _$getBestOfAllYearGamesAsyncAction
        .run(() => super.getBestOfAllYearGames());
  }

  final _$getBestOfLastMonthsAsyncAction =
      AsyncAction('_HomePageViewModelBase.getBestOfLastMonths');

  @override
  Future<void> getBestOfLastMonths() {
    return _$getBestOfLastMonthsAsyncAction
        .run(() => super.getBestOfLastMonths());
  }

  final _$getBestOfLastYearAsyncAction =
      AsyncAction('_HomePageViewModelBase.getBestOfLastYear');

  @override
  Future<void> getBestOfLastYear() {
    return _$getBestOfLastYearAsyncAction.run(() => super.getBestOfLastYear());
  }

  final _$getAllGenresAsyncAction =
      AsyncAction('_HomePageViewModelBase.getAllGenres');

  @override
  Future<void> getAllGenres() {
    return _$getAllGenresAsyncAction.run(() => super.getAllGenres());
  }

  final _$getAllThemesAsyncAction =
      AsyncAction('_HomePageViewModelBase.getAllThemes');

  @override
  Future<void> getAllThemes() {
    return _$getAllThemesAsyncAction.run(() => super.getAllThemes());
  }

  @override
  String toString() {
    return '''
bestOfAllYearGames: ${bestOfAllYearGames},
bestOfLastMonths: ${bestOfLastMonths},
bestOfLastYear: ${bestOfLastYear},
allGenres: ${allGenres},
allThemes: ${allThemes},
loadingBestOfAllYearGames: ${loadingBestOfAllYearGames},
loadingBestOfLastMonths: ${loadingBestOfLastMonths},
loadingBestOfLastYear: ${loadingBestOfLastYear},
loadingAllGenres: ${loadingAllGenres},
loadingAllThemes: ${loadingAllThemes}
    ''';
  }
}
