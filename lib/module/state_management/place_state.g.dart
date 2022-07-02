// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Places on _Places, Store {
  late final _$placesAtom = Atom(name: '_Places.places', context: context);

  @override
  ObservableList<PlaceModel> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableList<PlaceModel> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  late final _$_PlacesActionController =
      ActionController(name: '_Places', context: context);

  @override
  void addFavouritePlace(PlaceModel place) {
    final _$actionInfo = _$_PlacesActionController.startAction(
        name: '_Places.addFavouritePlace');
    try {
      return super.addFavouritePlace(place);
    } finally {
      _$_PlacesActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFavouritePlace(PlaceModel place) {
    final _$actionInfo = _$_PlacesActionController.startAction(
        name: '_Places.removeFavouritePlace');
    try {
      return super.removeFavouritePlace(place);
    } finally {
      _$_PlacesActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
places: ${places}
    ''';
  }
}
