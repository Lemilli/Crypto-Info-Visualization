part of 'scroll_cubit.dart';

class ScrollState extends Equatable {
  final ScrollPhysics scrollPhysics;

  const ScrollState(this.scrollPhysics);

  @override
  List<Object> get props => [scrollPhysics];
}
