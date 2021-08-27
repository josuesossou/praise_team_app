import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import '../components/arrowBack.dart';
import '../components/button.dart';
import '../components/dropDownNotes.dart';
import '../components/flexText.dart';
import '../components/textField.dart';
import '../models/SongModel.dart';
import '../services/dbSongsQuery.dart';
import '../components/SharedSoundCard.dart';
import '../utils/calculateTranspose.dart';


class SongPage extends StatefulWidget {
  SongPage({ @required this.song });

  final SongModel song;

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  EdgeInsets unifyMargin = EdgeInsets.symmetric(horizontal: 15);
  Transpose t = Transpose();
  bool editMode = false;
  String originalKey;
  int transpose;
  SongModel song;

  @override
  void initState() {
    setState(() {
      song = widget.song;
      originalKey = widget.song.originalkey;
      transpose = 0;
    });
    super.initState();
  }

  showEditMode() {
    setState(() {
      editMode = true;
    });
  }

  hideEditMode() {
    setState(() {
      editMode = false;
    });
  }

  onChangeOriginalKey(val) {
    setState(() {
      originalKey = val;
    });
  }

  onChangeTranspose(val) {
    setState(() {
      transpose = int.parse(val);
    });
  }

  updateSong() {
    if (originalKey == 'Not Set') {
      //TODO: Call error snackbar
    } else {
      String transposeKey = t.getTransposedKey(originalKey, transpose);
      Map<String, dynamic> data = {
        'originalkey': originalKey,
        'transposedNumber': transpose,
        'transposedKey': transposeKey
      };
      DbSongsQuery().updateSong(song.songId, data);
      //TODO show success snackbar
      hideEditMode();
      setState(() {
        song.originalkey = originalKey;
        song.transposedKey = transposeKey;
        song.transposedNumber = transpose;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight, 
      appBar: AppBar(
        leading: ArrowBack(),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () => showEditMode()
          )
        ],
        elevation: 0,
        title: Text('Song Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: Stack(
          children: [
            ScrolledContent(song: song,),
            editMode ? 
              EditSong(
                song: song,
                submit: updateSong,
                cancel: () => hideEditMode(),
                onChangeOriginalKey: onChangeOriginalKey,
                onChangeTranspose: onChangeTranspose,
                originalKey: originalKey,
              ) : Container(),
          ],
        ),
      )
    );
  }
}



class EditSong extends StatelessWidget {
  EditSong({ 
    @required this.song, 
    @required this.cancel, 
    @required this.submit,
    @required this.onChangeOriginalKey,
    @required this.originalKey,
    @required this.onChangeTranspose
  });

  final SongModel song;
  final String originalKey;
  final Function cancel, submit, onChangeOriginalKey, onChangeTranspose;

  @override
  Widget build(BuildContext context) {
    SizedBox columnSpacing = SizedBox(height: 10,);
    TextStyle style1 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    TextStyle style2 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    );
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Container(
      height: size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset.fromDirection(3),
            blurRadius: 5,
            // spreadRadius: 1
          )
        ]
      ),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlexText(
                  text: 'Set Original Key:',
                  style: style1,
                ),
                Container(
                  width: size.width * 0.3,
                  child: DropDownNotes(
                    dropdownValue: originalKey,
                    onValueChanged: onChangeOriginalKey,
                  )
                )
              ]
            )
          ),
          columnSpacing,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlexText(
                  text: 'Set Transpose:',
                  style: style1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFieldCop(
                    textAlign: TextAlign.center,
                    maxLength: 2,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.zero,
                    obscureText: false,
                    onChange: onChangeTranspose,
                    keyboardType: TextInputType.number,
                    radius: 0,
                    hintText: song.transposedNumber.toString(),
                    color: Colors.white,
                    border: BorderSide(width: 2, color: Colors.black),
                  ),
                )
              ]
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RectButton(
                onPress: cancel, 
                color: theme.primaryColorDark,
                child: Text('Cancel', style: style2,)
              ),
              SizedBox(width: 20),
              RectButton(
                onPress: submit, 
                color: theme.accentColor,
                child: Text('Update', style: style2,)
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddFileOptions extends StatelessWidget {
  AddFileOptions({ Key key }) : super(key: key);

  void _openFileExplorer() async {


//  setState(() => _loadingPath = true);
    try {
      // _directoryPath = null;
      await FilePicker.platform.pickFiles(
        // type: _pickingType,
        allowMultiple: true,
        // allowedExtensions: (_extension?.isNotEmpty ?? false)
        //     ? _extension?.replaceAll(' ', '').split(',')
        //     : null,
      );
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }


    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'doc'],
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorDark,
      height: 150,
      padding: EdgeInsets.only(bottom: 50, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RectButton(
            elevation: 2,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            
            onPress: () {
              _openFileExplorer();
            }, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.file_upload, size: 30,),
                SizedBox(height: 6),
                Text('Files')
              ],
            )
          ),
          SizedBox(width: 20),
          RectButton(
            elevation: 2, 
            onPress: () => {}, 
            child: Column(
              children: [
                Icon(Icons.link_sharp, size: 30,),
                SizedBox(height: 6),
                Text('URL')
              ],
            )
          ),
        ],
      ),
    );
  }
}

class ScrolledContent extends StatelessWidget {
  ScrolledContent({ @required this.song });

  final SongModel song;

  void showBottomSheet(context) => showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return AddFileOptions();
    },
  );

  @override
  Widget build(BuildContext context) {
    EdgeInsets unifyMargin = EdgeInsets.symmetric(horizontal: 15);
    SizedBox columnSpacing = SizedBox(height: 10,);
    TextStyle style1 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
    ); 
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.80 * size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SharedSoundCard(song: song),
            columnSpacing,
            columnSpacing,
            columnSpacing,
            Row(
              children: [
                FlexText(
                  margin: unifyMargin,
                  text: 'Music Sheets',
                  style: style1,
                ),
              ]
            ),
            columnSpacing,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            
              children: song.musicSheets.map((e) => (
                FileCardBtn()
              )).toList(),
            ),
            columnSpacing,
            columnSpacing,
            RectButton(
              margin: unifyMargin,
              color: Theme.of(context).accentColor,
              elevation: 3,
              onPress: () => showBottomSheet(context), 
              child: Row(
                children: [
                  FlexText(
                    alignment: Alignment.center,
                    text: 'Add File',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )
            ),
            columnSpacing,
            columnSpacing,
          ],
        ),
      ),
    );
  }
}

/// download posted file button
class FileCardBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: RectButton(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Colors.white,
        elevation: 3,
        padding: EdgeInsets.zero,
        onPress: () {}, 
        child:  Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    FlexText(
                      alignment: Alignment.center,
                      text: 'Download',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    FlexText(
                      alignment: Alignment.center,
                      text: 'File name',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    FlexText(
                      alignment: Alignment.center,
                      text: 'the name of the one who added',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RectButton(
                width: 40,
                raduis: 0,
                padding: EdgeInsets.zero,
                color: Colors.redAccent,
                onPress: (){},
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.white,
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }
}


