import 'package:equatable/equatable.dart';

abstract class ChartsEvent extends Equatable {
  const ChartsEvent();

  @override
  List<Object> get props => [];
}

class FetchChartsEvent extends ChartsEvent {}

class RefreshChartsEvent extends ChartsEvent {} 