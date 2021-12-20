// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_page.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsPageViewModel on _DetailsPageViewModelBase, Store {
  Computed<bool>? _$loadingImageComputed;

  @override
  bool get loadingImage =>
      (_$loadingImageComputed ??= Computed<bool>(() => super.loadingImage,
              name: '_DetailsPageViewModelBase.loadingImage'))
          .value;

  final _$_loadingImageAtom =
      Atom(name: '_DetailsPageViewModelBase._loadingImage');

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
      Atom(name: '_DetailsPageViewModelBase.gameCoverModel');

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

  final _$screenshotsModelAtom =
      Atom(name: '_DetailsPageViewModelBase.screenshotsModel');

  @override
  ScreenshotsModel? get screenshotsModel {
    _$screenshotsModelAtom.reportRead();
    return super.screenshotsModel;
  }

  @override
  set screenshotsModel(ScreenshotsModel? value) {
    _$screenshotsModelAtom.reportWrite(value, super.screenshotsModel, () {
      super.screenshotsModel = value;
    });
  }

  final _$screenshotsModelsAtom =
      Atom(name: '_DetailsPageViewModelBase.screenshotsModels');

  @override
  ObservableList<ScreenshotsModel>? get screenshotsModels {
    _$screenshotsModelsAtom.reportRead();
    return super.screenshotsModels;
  }

  @override
  set screenshotsModels(ObservableList<ScreenshotsModel>? value) {
    _$screenshotsModelsAtom.reportWrite(value, super.screenshotsModels, () {
      super.screenshotsModels = value;
    });
  }

  final _$getCoverAsyncAction =
      AsyncAction('_DetailsPageViewModelBase.getCover');

  @override
  Future<void> getCover() {
    return _$getCoverAsyncAction.run(() => super.getCover());
  }

  final _$getScreenshotAsyncAction =
      AsyncAction('_DetailsPageViewModelBase.getScreenshot');

  @override
  Future<void> getScreenshot() {
    return _$getScreenshotAsyncAction.run(() => super.getScreenshot());
  }

  @override
  String toString() {
    return '''
gameCoverModel: ${gameCoverModel},
screenshotsModel: ${screenshotsModel},
screenshotsModels: ${screenshotsModels},
loadingImage: ${loadingImage}
    ''';
  }
}
