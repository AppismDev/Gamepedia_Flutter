// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_page.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsPageViewModel on _DetailsPageViewModelBase, Store {
  Computed<bool>? _$isSeeMoreOpenComputed;

  @override
  bool get isSeeMoreOpen =>
      (_$isSeeMoreOpenComputed ??= Computed<bool>(() => super.isSeeMoreOpen,
              name: '_DetailsPageViewModelBase.isSeeMoreOpen'))
          .value;

  final _$_isSeeMoreOpenAtom =
      Atom(name: '_DetailsPageViewModelBase._isSeeMoreOpen');

  @override
  bool get _isSeeMoreOpen {
    _$_isSeeMoreOpenAtom.reportRead();
    return super._isSeeMoreOpen;
  }

  @override
  set _isSeeMoreOpen(bool value) {
    _$_isSeeMoreOpenAtom.reportWrite(value, super._isSeeMoreOpen, () {
      super._isSeeMoreOpen = value;
    });
  }

  final _$_DetailsPageViewModelBaseActionController =
      ActionController(name: '_DetailsPageViewModelBase');

  @override
  bool setIsSeeMoreOpen(bool value) {
    final _$actionInfo = _$_DetailsPageViewModelBaseActionController
        .startAction(name: '_DetailsPageViewModelBase.setIsSeeMoreOpen');
    try {
      return super.setIsSeeMoreOpen(value);
    } finally {
      _$_DetailsPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isSeeMoreOpen: ${isSeeMoreOpen}
    ''';
  }
}
