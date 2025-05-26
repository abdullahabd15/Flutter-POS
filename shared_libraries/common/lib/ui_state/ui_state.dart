import 'package:dependencies/equatable/equatable.dart';

enum UiState { initial, loading, error, hasData, noData }

extension ViewStateExtension on UiState {
  bool get isLoading => this == UiState.loading;

  bool get isInitial => this == UiState.initial;

  bool get isError => this == UiState.error;

  bool get isHasData => this == UiState.hasData;

  bool get isNoData => this == UiState.noData;
}

// ignore: must_be_immutable
class UiData<T> extends Equatable {
  UiState status;
  T? data;
  String message = "";

  UiData._({
    required this.status,
    this.data,
    this.message = "",
  });

  factory UiData.loaded({T? data}) {
    return UiData._(status: UiState.hasData, data: data);
  }

  factory UiData.error({
    required String message,
  }) {
    return UiData._(
      status: UiState.error,
      message: message,
    );
  }

  factory UiData.loading({required String message}) {
    return UiData._(status: UiState.loading, message: message);
  }

  factory UiData.initial() {
    return UiData._(status: UiState.initial);
  }

  factory UiData.noData({required String message}) {
    return UiData._(status: UiState.noData, message: message);
  }

  @override
  List<Object?> get props => [status, message, data];
}