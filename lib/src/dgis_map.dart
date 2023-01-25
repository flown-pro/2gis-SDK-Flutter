library dgis_maps_flutter;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'controller.dart';
import 'method_channel.g.dart';
import 'types/types.dart';

typedef MapCreatedCallback = void Function(DGisMapController controller);
typedef CameraStateChangedCallback = void Function(DataCameraState cameraState);

const String _kChannelName = 'pro.flown/dgis_maps';

class DGisMap extends StatefulWidget {
  const DGisMap({
    Key? key,
    this.onMapCreated,
    this.markers = const {},
    this.polylines = const {},
    this.onCameraStateChanged,
    this.myLocationEnabled = true,
    required this.initialPosition,
  }) : super(key: key);

  final CameraPosition initialPosition;

  final MapCreatedCallback? onMapCreated;

  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final bool myLocationEnabled;

  final CameraStateChangedCallback? onCameraStateChanged;

  @override
  State<DGisMap> createState() => _DGisMapState();
}

class _DGisMapState extends State<DGisMap> implements PluginFlutterApi {
  final _controller = Completer<DGisMapController>();
  late final PluginHostApi api;

  Set<Marker> _markers = const {};
  Set<Polyline> _polylines = const {};

  @override
  void initState() {
    _markers = widget.markers.toSet();
    _polylines = widget.polylines.toSet();
    super.initState();
  }

  @override
  void didUpdateWidget(DGisMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_markers != widget.markers) {
      _updateMarkers(
        toAdd: widget.markers.difference(_markers),
        toRemove: _markers.difference(widget.markers),
      );
      _markers = widget.markers.toSet();
    }
    if (_polylines != widget.polylines) {
      _updatePolylines(
        toAdd: widget.polylines.difference(_polylines),
        toRemove: _polylines.difference(widget.polylines),
      );
      _polylines = widget.polylines.toSet();
    }
    if (oldWidget.myLocationEnabled != widget.myLocationEnabled) {
      api.changeMyLocationLayerState(widget.myLocationEnabled);
    }
  }

  void _updateMarkers({
    required Set<Marker> toAdd,
    required Set<Marker> toRemove,
  }) =>
      api.updateMarkers(
        DataMarkerUpdates(
          toRemove: toRemove.toList(),
          toAdd: toAdd.toList(),
        ),
      );

  void _updatePolylines({
    required Set<Polyline> toAdd,
    required Set<Polyline> toRemove,
  }) =>
      api.updatePolylines(
        DataPolylineUpdates(
          toRemove: toRemove.toList(),
          toAdd: toAdd.toList(),
        ),
      );

  Future<void> onViewCreated(int id) async {
    api = PluginHostApi(id: id);
    final controller = DGisMapController(api, mapId: id);
    PluginFlutterApi.setup(this, id: id);
    if (!_controller.isCompleted) _controller.complete(controller);
    final MapCreatedCallback? onMapCreated = widget.onMapCreated;
    if (onMapCreated != null) {
      onMapCreated(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = DataCreationParams(
      position: widget.initialPosition.target,
      zoom: widget.initialPosition.zoom,
    ).encode();

    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _kChannelName,
        onPlatformViewCreated: onViewCreated,
        gestureRecognizers: const {},
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _kChannelName,
        onPlatformViewCreated: onViewCreated,
        gestureRecognizers: const {},
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return Text(
        '$defaultTargetPlatform is not yet supported by the maps plugin');
  }

  @override
  void onCameraStateChanged(CameraState cameraState) =>
      widget.onCameraStateChanged?.call(cameraState);
}
