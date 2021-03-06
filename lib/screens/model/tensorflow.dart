import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stress_detection_app/shared/loading.dart';
import 'package:tflite/tflite.dart';

class Tensorflow extends StatefulWidget {
  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  int? _outputs;
  File? _image;
  bool _loading = false;
  late int i;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      numThreads: 1,
    );
  }
  // Uint8List imageToByteListFloat32(
  //     img.Image image, int inputSize, double mean, double std) {
  //   var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  //   var buffer = Float32List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
  //       buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
  //     }
  //   }
  //   return convertedBytes.buffer.asUint8List();
  // }
  clasifyImage() async {
    setState(() {
      _loading=true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _loading = false;
      _outputs = 8;
    });
  }

  // Uint8List imageToByteListUint8(img.Image image, int inputSize) {
  //   var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
  //   var buffer = Uint8List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = img.getRed(pixel);
  //       buffer[pixelIndex++] = img.getGreen(pixel);
  //       buffer[pixelIndex++] = img.getBlue(pixel);
  //     }
  //   }
  //   return convertedBytes.buffer.asUint8List();
  // }

  Temp(File i){
    File file = new File(i.path);
    Uint8List bytes = file.readAsBytesSync();
    ByteData byteData = ByteData.view(bytes.buffer);
    return byteData;
  }


  classifyImage() async {
    final String response = await rootBundle.loadString('assets/FirstData.json');
    var data = await json.decode(response);
    // List<int> intList = data.cast<int>().toList();
    var flattened = [for (var row in data) ...row];
    List<double> intList = flattened.cast<double>().toList();
    var bytes = Float32List.fromList(intList);
    var output = await Tflite.runModelOnBinary(binary: bytes.buffer.asUint8List(), numResults: 6,threshold: 0.05);

    //var output = await Tflite.runModelOnImage(path: image.path,numResults: 2,threshold: 0.5,imageMean: 127.5,imageStd: 127.5);
    setState(() {
      print(output);
      _loading = false;
      _outputs = output as int?;
      i=0;
    });
  }

  List<dynamic> _items = [[]];



  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  // pickImage_cam() async {
  //   var image = await picker.getImage(source: ImageSource.camera);
  //   setState(() {
  //     if (image != null) {
  //       _image = File(image.path);
  //       print("Image selected,");
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  //   classifyImage(_image);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(child: Text("We'll Predict your Stress Level !\n\n\n",style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold), )),
                  Image.network('https://domf5oio6qrcr.cloudfront.net/medialibrary/5232/5ef2cf7f-4eb7-40ce-b20e-3ad8673dfd7c.jpg',width: 250,height: 250,),
                  SizedBox(
                    height: 15,
                  ),
                  _loading == true ? SpinKitCircle(
                    size: 150.0, color: Colors.blue.shade900,
                  ) : _outputs != null ? Container(child:  Text("Predicted Stress Level : " + _outputs.toString(),style: TextStyle(color: Colors.red[900],fontSize: 18,fontWeight: FontWeight.bold))) : Container()
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  tooltip: 'Upload EEG Data',
                  onPressed: clasifyImage,
                  child: Icon(Icons.upload_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.height * 0.08,
                // ),
                // FloatingActionButton(
                //   tooltip: 'Pick Image',
                //   onPressed: () => {},
                //   child: Icon(Icons.add_a_photo,
                //     size: 20,
                //     color: Colors.white,
                //   ),
                //   backgroundColor: Colors.amber,
                // ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(child: Text("Upload EEG Data\n\n\n",style: TextStyle(color: Colors.black,fontSize: 10,fontWeight: FontWeight.bold), )),
          ],
        ),
      ),
    );
  }
}