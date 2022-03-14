part of 'crypto_data_bloc.dart';

abstract class CryptoDataState extends Equatable {
  const CryptoDataState();

  @override
  List<Object?> get props => [];
}

class CryptoDataInitial extends CryptoDataState {}

class CryptoDataLoading extends CryptoDataState {}

class CryptoDataError extends CryptoDataState {
  final String? message;

  const CryptoDataError(this.message);
}

class CryptoDataLoaded extends CryptoDataState {
  final List<CryptocurrencyModel> bitcoins;
  final List<CryptocurrencyModel> ethereums;
  final List<CryptocurrencyModel> solanas;
  final List<CryptocurrencyModel> latestSemantics;

  CryptoDataLoaded({
    required this.bitcoins,
    required this.ethereums,
    required this.solanas,
    required this.latestSemantics,
  });

  @override
  List<Object?> get props => [bitcoins, ethereums, solanas];

  // Extra variables for cartesian charts that don't change (no setters)
  TrackballBehavior get trackballBehaviorPrice => _trackballBehaviorPrice;
  TrackballBehavior get trackballBehaviorTweetCount =>
      _trackballBehaviorTweetCount;
  TrackballBehavior get trackballBehaviorSemantics =>
      _trackballBehaviorSemantics;
  ZoomPanBehavior get zoomPanBehavior => _zoomPanBehavior;

  final _trackballBehaviorPrice = TrackballBehavior(
    // Enables the trackball
    enable: true,
    tooltipSettings: const InteractiveTooltip(enable: true),
    activationMode: ActivationMode.singleTap,
    builder: (context, trackballDetails) => trackballDetails.point == null
        ? const SizedBox()
        : TrackballPopUpWidget(
            trackballDetails: trackballDetails,
            type: CartesianGraphType.price,
          ),
  );

  final _trackballBehaviorTweetCount = TrackballBehavior(
    // Enables the trackball
    enable: true,
    activationMode: ActivationMode.singleTap,
    tooltipSettings: const InteractiveTooltip(enable: true),
    builder: (context, trackballDetails) => trackballDetails.point == null
        ? const SizedBox()
        : TrackballPopUpWidget(
            trackballDetails: trackballDetails,
            type: CartesianGraphType.tweetCount,
          ),
  );

  final _trackballBehaviorSemantics = TrackballBehavior(
    // Enables the trackball
    enable: true,
    activationMode: ActivationMode.singleTap,
    tooltipSettings: const InteractiveTooltip(enable: true),
    builder: (context, trackballDetails) => trackballDetails.point == null
        ? const SizedBox()
        : TrackballPopUpWidget(
            trackballDetails: trackballDetails,
            type: CartesianGraphType.semantics,
          ),
  );

  final _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    zoomMode: ZoomMode.x,
  );
}
