// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
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

  @override
  String toString() {
    return '''
bestOfAllYearGames: ${bestOfAllYearGames},
bestOfLastMonths: ${bestOfLastMonths},
bestOfLastYear: ${bestOfLastYear}
    ''';
  }
}
