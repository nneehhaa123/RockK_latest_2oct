import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/milestone.dart';
//import '../providers/products.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:twinkle_button/twinkle_button.dart';

class MLformScreen extends StatefulWidget {
  //const MLformScreen({ Key? key }) : super(key: key);
  static const routeName = '/milestone-form';

  @override
  _MLformScreenState createState() => _MLformScreenState();
}

class _MLformScreenState extends State<MLformScreen> {
  final _messageFocusNode = FocusNode();
  final _videoFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedML = MLItem(id: null, mlno: 0, message: '', mUrl: [], isVideo: '');
  var _initValues = {
    'mlno': '',
    'message': '',
    'mUrl': [],
    'isVideo': '',
  };
  var _isInit = true;
  var _isLoading = false;
  List<String> ml_loc = [];
  List<Asset> imagesList = [];
  String _error = 'Selectionner une image';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final MlId = ModalRoute.of(context).settings.arguments as String;
      if (MlId != null) {
        _editedML =
            Provider.of<Milestone>(context, listen: false).findById(MlId);
        _initValues = {
          'mlno': _editedML.mlno.toString(),
          'message': _editedML.message,
          'mUrl': _editedML.mUrl,
          'isVideo': _editedML.isVideo,
        };
        // _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _messageFocusNode.dispose();
    _videoFocusNode.dispose();
    //_videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedML.id != null) {
      await Provider.of<Milestone>(context, listen: false)
          .updateProduct(_editedML.id, _editedML);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Your Milestone has been updated'),
          content: Text('Thank You!'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    } else {
      try {
        await Provider.of<Milestone>(context, listen: false)
            .addProduct(_editedML, ml_loc);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Your Milestones have been added!'),
            content: Text('Thank You!'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      } catch (error) {
        print(error);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imagesList.length, (index) {
        Asset asset = imagesList[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<List<String>> uploadFiles(List<Asset> _images) async {
    //List imageUrls = [];
    List<String> imageUrls = [];
    // await Future.wait(_images.map((_image) async {
    //   String imu = await uploadFile(_image);
    //   await imageUrls.add(imu);
    // }));
    await Firebase.initializeApp();
    await Future.wait(_images.map((element) async {
      String imu = await uploadFile(element);
      //await imageUrls.add(imu);
      imageUrls.add(imu);
    }));
    return imageUrls;
  }

  Future<String> uploadFile(Asset _image) async {
    FirebaseStorage _MLstorage = FirebaseStorage.instance;
    //String now_time_ML = DateTime.now().toIso8601String();

    //Create a reference to the location you want to upload to in firebase
    Reference reference = _MLstorage.ref().child("MLimages${_image.name}"); //

    final filePath =
        await FlutterAbsolutePath.getAbsolutePath(_image.identifier);

    File imFile = File(filePath);

    //Upload the file to firebase
    UploadTask uploadTask = reference.putFile(imFile);

    // Waits till the file is uploaded then stores the download url

    String MLlocation = await (await uploadTask).ref.getDownloadURL();
    //print('neha2');
    //print(MLlocation);

    return MLlocation;
  }

  Future<List<String>> loadAssets() async {
    //List<File> MLimList = [];
    String error = 'No Error Dectected';
    List<Asset> resultList = [];
    //List<File> fileImageArray = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 30,
        enableCamera: true,
        selectedAssets: resultList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
// need to fix this as make uploading time real time as delay
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 5), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text('Uploading...'),
            );
          });

      // resultList.forEach((element) async {
      //   final filePath =
      //       await FlutterAbsolutePath.getAbsolutePath(element.identifier);

      //   File tempfile = File(filePath);
      //   if (tempfile.existsSync()) {
      //     await fileImageArray.add(tempfile);
      //   }
      // });
      // print(fileImageArray);
      //return fileImageArray;

      // MLimList = resultList.forEach((im) {
      //   return File(im);
      // });
      List<String> ll = await (uploadFiles(resultList));

      return ll;
    } on Exception catch (e) {
      error = e.toString();
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    // setState(() {
    //   imagesList = resultList;
    //   _error = error;
    // });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Please add your milestones!',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Container(
                        child: Column(children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TwinkleButton(
                          buttonTitle: Text(
                            "Pick images From Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          buttonColor: Colors.blue.shade900,
                          buttonWidth: 200,
                          onclickButtonFunction: () {
                            loadAssets().then((value) {
                              //print('1');
                              //print(value);
                              ml_loc = value;
                              //print(ml_loc);
                            });
                          }),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     loadAssets().then((value) {
                      //       //print('1');
                      //       //print(value);
                      //       ml_loc = value;
                      //       //print(ml_loc);
                      //     });
                      //   },
                      //   child: Text(
                      //     "Pick images From Gallery",
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: buildGridView(),
                      // ),
                    ])),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: _initValues['mlno'],
                      decoration: InputDecoration(labelText: 'MileStone No:'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_messageFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedML = MLItem(
                            id: _editedML.id,
                            mlno: int.parse(value),
                            message: _editedML.message,
                            mUrl: _editedML.mUrl,
                            isVideo: _editedML.isVideo);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['message'],
                      decoration: InputDecoration(
                          labelText: 'Please enter details about milestone'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _messageFocusNode,
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(_videoFocusNode);
                      // },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        // if (value.length < 10) {
                        //   return 'Should be at least 10 characters long.';
                        // }
                        return null;
                      },
                      onSaved: (value) {
                        _editedML = MLItem(
                            id: _editedML.id,
                            mlno: _editedML.mlno,
                            message: value,
                            mUrl: _editedML.mUrl,
                            isVideo: _editedML.isVideo);
                      },
                    ),
                    // TextFormField(
                    //   initialValue: _initValues['isVideo'],
                    //   decoration:
                    //       InputDecoration(labelText: 'Is this a video?'),
                    //   textInputAction: TextInputAction.next,
                    //   //keyboardType: TextInputType.number,
                    //   focusNode: _videoFocusNode,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please provide a value.';
                    //     }
                    //     return null;
                    //   },
                    //   onSaved: (value) {
                    //     _editedML = MLItem(
                    //         id: _editedML.id,
                    //         mlno: _editedML.mlno,
                    //         message: _editedML.message,
                    //         mUrl: _editedML.mUrl,
                    //         isVideo: value);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
