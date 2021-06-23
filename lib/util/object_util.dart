part of 'common.dart';

extension GeneralUtilsObjectExtension on Object {
  bool get isNull => this == null;

  bool get isNotNull => this != null;

  bool get isNullOrEmpty =>
      isNull ||
      _isStringObjectEmpty ||
      _isIterableObjectEmpty ||
      _isMapObjectEmpty ||
      _isListEmpty;

  bool get isNullEmptyOrFalse =>
      isNull ||
      _isStringObjectEmpty ||
      _isIterableObjectEmpty ||
      _isMapObjectEmpty ||
      _isListEmpty ||
      _isBoolObjectFalse;

  bool get isNullEmptyFalseOrZero =>
      isNull ||
      _isStringObjectEmpty ||
      _isIterableObjectEmpty ||
      _isMapObjectEmpty ||
      _isListEmpty ||
      _isBoolObjectFalse ||
      _isNumObjectZero;

  bool get _isStringObjectEmpty =>
      (this is String) ? (this as String).isEmpty : false;

  bool get _isIterableObjectEmpty =>
      (this is Iterable) ? (this as Iterable).isEmpty : false;

  bool get _isListEmpty => (this is List) ? (this as List).isEmpty : false;

  bool get _isMapObjectEmpty => (this is Map) ? (this as Map).isEmpty : false;

  bool get _isBoolObjectFalse =>
      (this is bool) ? (this as bool) == false : false;

  bool get _isNumObjectZero => (this is num) ? (this as num) == 0 : false;
}
