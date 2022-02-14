import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'scroll_state.dart';

class ScrollCubit extends Cubit<ScrollState> {
  ScrollCubit() : super(const ScrollState(AlwaysScrollableScrollPhysics()));

  void disable() {
    emit(const ScrollState(NeverScrollableScrollPhysics()));
  }

  void enable() {
    emit(const ScrollState(AlwaysScrollableScrollPhysics()));
  }
}
