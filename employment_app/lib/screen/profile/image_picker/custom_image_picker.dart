import 'dart:io';

import 'package:employment_app/style/Style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomImagePicker extends StatefulWidget {
  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  String _retrieveDataError;

  //picked photo save in this variable
  PickedFile _imageFile;

  //error
  dynamic _pickImageError;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('lib/assets/images/user_avatar.png'),
                      );
                    case ConnectionState.done:
                      return _previewImage();

                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick Image Error${snapshot.error}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return CircleAvatar(
                          radius: 85,
                          backgroundColor: primaryColor,
                          backgroundImage:
                              AssetImage('lib/assets/images/user_avatar.png'),
                        );
                      }
                  }
                })
            : _previewImage(),
      ),
      Positioned(
        right: 85,
          child: Container(
        margin: EdgeInsets.only(top: screenHeight(context) * 0.1),
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            // isVideo = false;
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          heroTag: 'image0',
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo_library),
        ),
      ))
    ]);
//        floatingActionButton:
//            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
//          Semantics(
//            label: 'image_picker_example_from_gallery',
//            child: FloatingActionButton(
//              onPressed: () {
//                // isVideo = false;
//                _onImageButtonPressed(ImageSource.gallery, context: context);
//              },
//              heroTag: 'image0',
//              tooltip: 'Pick Image from gallery',
//              child: const Icon(Icons.photo_library),
//            ),
//          ),
//        ]);
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
          source: source, maxHeight: screenHeight(context) * 0.3);
      setState(() {
        _imageFile = pickedFile;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_image', pickedFile.path);

    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetriveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        return Image.network(_imageFile.path);
      } else {
        return CircleAvatar(
            radius: 70,
            // backgroundImage: Image.file(File(_imageFile.path)),
            backgroundImage: FileImage(File(_imageFile.path))
            //  child: ClipOval(child: Image.file(File(_imageFile.path)),)
            //label: 'image_picker',
            );
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const CircleAvatar(
        radius: 85,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(
          'lib/assets/images/user_avatar.png',
        ),
      );
    }
  }

  Text _getRetriveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
