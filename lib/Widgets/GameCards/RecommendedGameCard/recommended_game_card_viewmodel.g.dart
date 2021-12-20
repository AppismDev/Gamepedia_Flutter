// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_game_card_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecommendedGameCardViewModel
    on _RecommendedGameCardViewModelBase, Store {
  Computed<bool>? _$loadingImageComputed;

  @override
  bool get loadingImage =>
      (_$loadingImageComputed ??= Computed<bool>(() => super.loadingImage,
              name: '_RecommendedGameCardViewModelBase.loadingImage'))
          .value;

  final _$_loadingImageAtom =
      Atom(name: '_RecommendedGameCardViewModelBase._loadingImage');

  @override
  bool get _loadingImage {
    _$_loadingImageAtom.reportRead();
    return super._loadingImage;
  }

  @override
  set _loadingImage(bool value) {
    _$_loadingImageAtom.reportWrite(value, super._loadingImage, () {
      super._loadingImage = value;
    });
  }

  final _$gameCoverModelAtom =
      Atom(name: '_RecommendedGameCardViewModelBase.gameCoverModel');

  @override
  CoverModel? get gameCoverModel {
    _$gameCoverModelAtom.reportRead();
    return super.gameCoverModel;
  }

  @override
  set gameCoverModel(CoverModel? value) {
    _$gameCoverModelAtom.reportWrite(value, super.gameCoverModel, () {
      super.gameCoverModel = value;
    });
  }

  final _$getCoverAsyncAction =
      AsyncAction('_RecommendedGameCardViewModelBase.getCover');

  @override
  Future<void> getCover() {
    return _$getCoverAsyncAction.run(() => super.getCover());
  }

  @override
  String toString() {
    return '''
gameCoverModel: ${gameCoverModel},
loadingImage: ${loadingImage}
    ''';
  }
}
