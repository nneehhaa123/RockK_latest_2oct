import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/kiaansh_party_screen.dart';
import 'package:twinkle_button/twinkle_button.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter_video_compress/flutter_video_compress.dart';
//import 'package:video_compress/video_compress.dart';

//import 'package:intl/intl.dart';

class AddWishesScreen extends StatefulWidget {
  static const routeName = '/add-wishes';

  @override
  _AddWishesScreenState createState() => _AddWishesScreenState();
}

class _AddWishesScreenState extends State<AddWishesScreen> {
  //final _flutterVideoCompress = FlutterVideoCompress();
  //Subscription _subscription;

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    name: '',
    relation: '',
    message: '',
    imageUrl: '',
  );
  var _initValues = {
    'name': '',
    'relation': '',
    'message': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;
  var loc = '';
  //var now_time = DateTime.now().ToString("yyyyMMddHHmmssfff");

  String nowTime = DateTime.now().toIso8601String();
  //String now_time = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  double _progressState = 0;
  final _loadingStreamCtrl = StreamController<bool>.broadcast();
  // MediaInfo _compressedVideoInfo = MediaInfo(path: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // _subscription =
    //     _flutterVideoCompress.compressProgress$.subscribe((progress) {
    //   setState(() {
    //     _progressState = progress;
    //   });
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'name': _editedProduct.name,
          'relation': _editedProduct.relation,
          'message': _editedProduct.message,
          'imageUrl': _editedProduct.imageUrl,
        };
        // _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _videoPlayerController.dispose();
    //_subscription.unsubscribe();
    _loadingStreamCtrl.close();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  // Future<MediaInfo> runFlutterVideoCompressMethods(File videoFile) async {
  //   _loadingStreamCtrl.sink.add(true);

  //   var _startDateTime = DateTime.now();
  //   print('[Compressing Video] start');
  //   final compressedVideoInfo = await _flutterVideoCompress.compressVideo(
  //     videoFile.path,
  //     quality: VideoQuality.DefaultQuality,
  //     deleteOrigin: false,
  //   );
  //   print(compressedVideoInfo.toJson().toString());
  //   print(
  //       '[Compressing Video] done! ${DateTime.now().difference(_startDateTime).inSeconds}s');

  //   setState(() {
  //     _compressedVideoInfo = compressedVideoInfo;
  //   });
  //   _loadingStreamCtrl.sink.add(false);

  //   return compressedVideoInfo;
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Please Enter the details below!'),
          content: Text('Enter your wishes'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
                //Navigator.of(context).pushReplacementNamed(KiaParty.routeName);
              },
            )
          ],
        ),
      );
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
      _videoPlayerController.pause();
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Your wishes sent to Kiaansh!'),
          content: Text('Thank You!'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                //Navigator.of(ctx).pop();
                //Navigator.of(context).pushReplacementNamed(KiaParty.routeName);
              },
            )
          ],
        ),
      );
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct, loc);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Your wishes sent to Kiaansh!'),
            content: Text('Thank You!'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushNamed(KiaParty.routeName);
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
    Navigator.of(context).pushNamed(KiaParty.routeName);
    //Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  File _video;
  final picker = ImagePicker();
  VideoPlayerController _videoPlayerController;

// This funcion will helps you to pick a Video File
  Future<String> _pickVideo() async {
    // const waurl =
    //     'https://api.whatsapp.com/send?phone=+91-9035710320&text=Hello';
    // await launch(waurl);
    await Firebase.initializeApp();
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);

    _video = File(pickedFile.path);
    //print(await _video.length());
    int vSize = await _video.length();
    print(vSize);
    print(_video.path);

    //compress

    // MediaInfo compVideoInfo = await VideoCompress.compressVideo(
    //   pickedFile.path,
    //   quality: VideoQuality.DefaultQuality,
    //   deleteOrigin: false,
    // );
    // print(compVideoInfo.toJson().toString());

    // File _compVideo = File(compVideoInfo.path);

    // int compvSize = await _compVideo.length();

    // print(compvSize);

    if (vSize >= 50000000) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Uploading Failed!'),
          content: Text('Please upload video less than 50MB'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
                //Navigator.of(ctx).pushReplacementNamed(KiaParty.routeName);
              },
            )
          ],
        ),
      );
    } else {
      await showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 10), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text('Uploading...'),
            );
          });

      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });

      FirebaseStorage _storage = FirebaseStorage.instance;

      //Create a reference to the location you want to upload to in firebase
      Reference reference = _storage.ref().child("images$nowTime");

      //Upload the file to firebase
      UploadTask uploadTask = reference.putFile(_video);

      // Waits till the file is uploaded then stores the download url

      String location = await (await uploadTask).ref.getDownloadURL();

      //print(location);

      //returns the download url
      return location;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Send wishes to Kiaansh!'),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                          Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0, 1],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                if (_video != null)
                                  _videoPlayerController.value.isInitialized
                                      ? AspectRatio(
                                          aspectRatio: _videoPlayerController
                                              .value.aspectRatio,
                                          child: VideoPlayer(
                                              _videoPlayerController),
                                        )
                                      : Container()
                                else
                                  Text(
                                    "Click on Pick Video to select video",
                                    //style: TextStyle(fontSize: 18.0),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                TwinkleButton(
                                    buttonTitle: Text(
                                      'Pick Video From Gallery',
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
                                      _pickVideo().then((val) {
                                        loc = val;
                                        //print('neha4');
                                        print(loc);
                                      });
                                    }),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     _pickVideo().then((val) {
                                //       loc = val;
                                //       //print('neha4');
                                //       print(loc);
                                //     });
                                //   },
                                //   child: Text("Pick Video From Gallery",
                                //       style: TextStyle(fontSize: 18.0)),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            //height: deviceSize.height * 0.3,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: _initValues['name'],
                                  decoration:
                                      InputDecoration(labelText: 'Name'),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_priceFocusNode);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your name.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedProduct = Product(
                                      name: value,
                                      relation: _editedProduct.relation,
                                      message: _editedProduct.message,
                                      imageUrl: _editedProduct.imageUrl,
                                      id: _editedProduct.id,
                                    );
                                  },
                                ),
                                TextFormField(
                                  initialValue: _initValues['relation'],
                                  decoration: InputDecoration(
                                      labelText: 'Aap Kiaansh k he kaun?'),
                                  textInputAction: TextInputAction.next,
                                  //keyboardType: TextInputType.number,
                                  focusNode: _priceFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context)
                                        .requestFocus(_descriptionFocusNode);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your relationship.';
                                    }
                                    // if (double.tryParse(value) == null) {
                                    //   return 'Please enter a valid number.';
                                    // }
                                    // if (double.parse(value) <= 0) {
                                    //   return 'Please enter a number greater than zero.';
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedProduct = Product(
                                      name: _editedProduct.name,
                                      relation: value,
                                      message: _editedProduct.message,
                                      imageUrl: _editedProduct.imageUrl,
                                      id: _editedProduct.id,
                                    );
                                  },
                                ),
                                TextFormField(
                                  initialValue: _initValues['message'],
                                  decoration: InputDecoration(
                                      labelText: 'Please enter your wishes'),
                                  maxLines: 3,
                                  keyboardType: TextInputType.multiline,
                                  focusNode: _descriptionFocusNode,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your wishes.';
                                    }
                                    // if (value.length < 10) {
                                    //   return 'Should be at least 10 characters long.';
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _editedProduct = Product(
                                      name: _editedProduct.name,
                                      relation: _editedProduct.relation,
                                      message: value,
                                      imageUrl: _editedProduct.imageUrl,
                                      id: _editedProduct.id,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment(0.9, 1.0),
                              child: ElevatedButton(
                                child: Text('Save'),
                                onPressed: _saveForm,
                              )),
                          // Align(
                          //     alignment: Alignment(-0.1, 0.9),
                          //     child: FloatingActionButton(
                          //       child: Icon(Icons.arrow_back_rounded),
                          //       onPressed: () {
                          //         Navigator.of(context).pop();
                          //       },
                          //       backgroundColor: Colors.red,
                          //     )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
