// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class Custom3dObjectsScreen extends StatefulWidget {
  final String fileUri;
  Custom3dObjectsScreen({
    Key? key,
    required this.fileUri,
  }) : super(key: key);

  @override
  State<Custom3dObjectsScreen> createState() => _Custom3dObjectsScreenState();
}

class _Custom3dObjectsScreenState extends State<Custom3dObjectsScreen> {
  ARSessionManager? sessionManager;
  ARObjectManager? objectManager;
  ARAnchorManager? anchorManager;
  List<ARNode> allNodes = [];
  List<ARAnchor> allAnchor = [];

  String? localFilePath; // Added to store local file path

  whenARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    sessionManager = arSessionManager;
    objectManager = arObjectManager;
    anchorManager = arAnchorManager;

    sessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
      handlePans: true,
      handleRotation: true,
    );
    objectManager!.onInitialize();
    sessionManager!.onPlaneOrPointTap = whenPlaneDetedtedAndUserTapped;
    objectManager!.onPanStart = whenOnPanStarted;
    objectManager!.onPanChange = whenOnPanChanged;
    objectManager!.onPanEnd = whenOnPanEnded;
    objectManager!.onRotationStart = whenOnrotationStarted;
    objectManager!.onRotationChange = whenOnrotationChanged;
    objectManager!.onRotationEnd = whenOnrotationEnded;
  }

  vector64.Vector4 _currentRotation = vector64.Vector4(1.0, 0, 0, -1.5);
  vector64.Vector3 _currentScale = vector64.Vector3(1, 1, 1);
  Future<void> whenPlaneDetedtedAndUserTapped(
      List<ARHitTestResult> tapResults) async {
    var userHitTestResult = tapResults
        .firstWhere((userTap) => userTap.type == ARHitTestResultType.plane);
    if (userHitTestResult != null) {
      //new anchor
      var newPlaneARAnchor =
          ARPlaneAnchor(transformation: userHitTestResult.worldTransform);
      bool? isAnchorAdded = await anchorManager!.addAnchor(newPlaneARAnchor);
      if (isAnchorAdded!) {
        allAnchor.add(newPlaneARAnchor);
        //new node
        var nodeNew3dObject = ARNode(
          type: NodeType.webGLB, //.glb 3d model //size 10 - 20MB
          uri: widget.fileUri,
          scale: _currentScale,
          position: vector64.Vector3(0, 0, 0),
          rotation: _currentRotation,
        );
        bool? isNewNodeAddedToNewAnchor = await objectManager!
            .addNode(nodeNew3dObject, planeAnchor: newPlaneARAnchor);
        if (isNewNodeAddedToNewAnchor!) {
          allNodes.add(nodeNew3dObject);
        } else {
          sessionManager!.onError("Attaching Node to Anchor Failed.");
        }
      } else {
        sessionManager!.onError("Adding Anchor Failed.");
      }
    }
  }

  whenOnPanStarted(String node3dObjectName) {
    print("Stared Panning Node = " + node3dObjectName);
  }

  whenOnPanChanged(String node3dObjectName) {
    print("Continued Panning Node = " + node3dObjectName);
  }

  whenOnPanEnded(String node3dObjectName, Matrix4 transform) {
    print("Ended Panning Node = " + node3dObjectName);
    final pannedNode =
        allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  whenOnrotationStarted(String node3dObjectName) {
    print("Started Rotating Node =" + node3dObjectName);
  }

  whenOnrotationChanged(String node3dObjectName) {
    print("Continued Rotating Node =" + node3dObjectName);
  }

  whenOnrotationEnded(String node3dObjectName, Matrix4 transform) {
    print("Ended Rotating Node =" + node3dObjectName);
    final pannedNode =
        allNodes.firstWhere((node) => node.name == node3dObjectName);
  }

  Future<void> removeEveryObject() async {
    allAnchor.forEach((eachAnchor) {
      anchorManager!.removeAnchor(eachAnchor);
    });
    allAnchor = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom 3d Objects"),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Stack(
          children: [
            ARView(
              planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              onARViewCreated: whenARViewCreated,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    removeEveryObject();
                  },
                  child: const Text("Remove"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
