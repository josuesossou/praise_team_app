
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:lgcogpraiseteam/components/showAlert.dart';
import 'package:lgcogpraiseteam/entry/dashboard.dart';
import 'package:lgcogpraiseteam/services/userQuery.dart';
import 'package:uuid/uuid.dart';
// Componenents
import '../components/arrowBack.dart';
import '../components/button.dart';
import '../components/dropDownNotes.dart';
import '../components/flexText.dart';
import '../components/textField.dart';
import '../components/SharedSoundCard.dart';
import '../components/loader.dart';
import '../components/scaffoldMessages.dart';
// Helpers
import '../services/dbSongsQuery.dart';
import '../utils/calculateTranspose.dart';
import '../models/ModelProvider.dart';
import '../models/Song.dart';

class SongPage extends StatefulWidget {
  SongPage({ @required this.song });

  final Song song;

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  EdgeInsets unifyMargin = EdgeInsets.symmetric(horizontal: 15);
  TransposeCalculation t = TransposeCalculation();
  DbSongsQuery _dbSongsQuery = DbSongsQuery();
  bool editMode = false;
  String originalKey;
  UserData userName; // name of the user singing in the transpose key
  int transpose;
  Song song;

  @override
  void initState() {
    setState(() {
      song = widget.song;
      originalKey = widget.song.originalkey;
      userName = null;
      transpose = 0;
    });
    super.initState();
  }

  _showEditMode() {
    setState(() {
      editMode = true;
    });
  }

  _hideEditMode() {
    setState(() {
      editMode = false;
    });
  }

  _onChangeOriginalKey(val) { // dropdown changing the original key
    setState(() {
      originalKey = val;
    });
  }

  _onChangeUserName(val) { // dropdown changing the user names.
    setState(() {
      userName = val;
    });
  }

  _onChangeTranspose(val) {
    setState(() {
      transpose = int.parse(val);
    });
  }

  void updateSong() async {
    if (originalKey == 'Not Set') {
      showError(context, 'Change Key');
    } else {
      Song _updatedSong;

      try {
        if (userName != null && userName.id != 'None') {
          final _transId = Uuid().v1();
          String transposeKey = t.getTransposedKey(originalKey, transpose);

          final newTranData = {
            'id': _transId,
            'transposeKey': transposeKey,
            'transposeNum': transpose,
            'userName': userName.name,
            'songId': song.songId,
            'userId': userName.uid
          };

          var res =  await TransposeQuery().addTransposeKey(newTranData);

          _updatedSong = song.copyWith(
            originalkey: originalKey,
            transposeList: res == "NEW"? [_transId, ...song.transposeList]
                                        : song.transposeList
          );
        } else {
          _updatedSong = song.copyWith(
            originalkey: originalKey,
          );
        }
  
        await _dbSongsQuery.updateSong(_updatedSong);

        _hideEditMode();
        setState(() {
          song = _updatedSong;
        });
        showSuccess(context, 'Succefully updated keys');

      } catch (e) {
      }
    }
  }

  void _reportSong() {
    var newSong = song.copyWith(
      reported: true
    );

    _dbSongsQuery.updateSong(newSong)
    .then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => DashboardScreen(),
        ),
      );
      showSuccess(
        context, 
        "Report sent! Video will not be displayed in the future"
      );
    });
    // Navigator.of(context).pop();
   


  }

  void showBottomSheet(context) => showModalBottomSheet<void>(
    context: context,
    isDismissible: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return AlertContent(
        func: _reportSong,
        aproveKeyWord: 'Report',
        content: 'Report song for inappropriate content?',
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColorLight, 
      floatingActionButton: editMode ? Container()
      : ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: _theme.accentColor,
          padding: EdgeInsets.all(20)
        ),
        child: Icon(Icons.edit, size: 30,),
        onPressed: () => _showEditMode()
      ),
      appBar: AppBar(
        leading: ArrowBack(),
        actions: [
          song.reported ? Container() : IconButton(
            icon: Icon(Icons.report), 
            onPressed: () => showBottomSheet(context)
          )
        ],
        elevation: 0,
        title: Text('Song Page'),
        centerTitle: true,
        backgroundColor: _theme.accentColor,
      ),
      body: Container(
        child: Stack(
          children: [
            ScrolledContent(song: song,),
            editMode ? 
              EditSong(
                song: song,
                submit: updateSong,
                cancel: () => _hideEditMode(),
                onChangeOriginalKey: _onChangeOriginalKey,
                onChangeTranspose: _onChangeTranspose,
                onChangeUserName: _onChangeUserName,
                originalKey: originalKey,
                userName: userName
              ) : Container(),
          ],
        ),
      )
    );
  }
}

// Editing song form
class EditSong extends StatelessWidget {
  EditSong({ 
    @required this.song, 
    @required this.cancel, 
    @required this.submit,
    @required this.onChangeOriginalKey,
    @required this.originalKey,
    @required this.userName,
    @required this.onChangeTranspose,
    @required this.onChangeUserName
  });

  final Song song;
  final String originalKey;
  final Function cancel, submit, onChangeOriginalKey, onChangeTranspose,
        onChangeUserName;
  final UserData userName;
  final TransposeCalculation _transpose = TransposeCalculation();


  @override
  Widget build(BuildContext context) {
    SizedBox columnSpacing = SizedBox(height: 10,);
    ThemeData _theme = Theme.of(context);
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
      height: size.height * 0.5,
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
                    items: _transpose.listOfNotes,
                    dropdownValue: originalKey,
                    onValueChanged: onChangeOriginalKey,
                  )
                )
              ]
            )
          ),

          columnSpacing,
          columnSpacing,
          columnSpacing,
          FlexText(
            text: 'Add New Transpose Key',
            style: style1,
          ),

          columnSpacing,
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
                    hintText: "0",
                    color: Colors.white,
                    border: BorderSide(width: 2, color: Colors.black),
                  ),
                )
              ]
            ),
          ),

          columnSpacing,
          Container(
            width: size.width * 0.9,
            child: FutureBuilder(
              future: DbUserQuery().getUsersData(),
              builder: (BuildContext contex, 
                            AsyncSnapshot<List<UserData>> snapshot) {
                Widget widget;

                if (snapshot.hasData) {
                  List<UserData> listOfUserNames = snapshot.data;
                  if (listOfUserNames.isNotEmpty && 
                      listOfUserNames[0].id != 'None') {
                    listOfUserNames.insert(0, UserData(
                      id: 'None',
                      organizationId: 'None',
                      uid: 'None',
                      color: '0xffffffff',
                      name: 'Select Singer',
                      role: 'None'
                    ));
                  }
                  widget = listOfUserNames.isEmpty ?
                  Text('No User In App') :
                  DropDownUserData(
                    items: listOfUserNames,
                    dropdownValue: userName == null?
                                    listOfUserNames[0]
                                    : userName,
                    onValueChanged: onChangeUserName,
                  );
                } else if (snapshot.hasError) {
                  widget = Text('Unable to find Users');
                } else {
                  widget = Loader(
                    color: _theme.accentColor,
                  );
                }

                return widget;
              }
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

  final Song song;

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
    // EdgeInsets unifyMargin = EdgeInsets.symmetric(horizontal: 15);
    SizedBox columnSpacing = SizedBox(height: 10,);
    // TextStyle style1 = TextStyle(
    //   fontSize: 20,
    //   fontWeight: FontWeight.bold
    // ); 
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
            // later
            // Row(
            //   children: [
            //     FlexText(
            //       margin: unifyMargin,
            //       text: 'Music Sheets',
            //       style: style1,
            //     ),
            //   ]
            // ),
            columnSpacing,
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            
            //   children: song.musicSheets.map((e) => (
            //     FileCardBtn()
            //   )).toList(),
            // ),
            columnSpacing,
            columnSpacing,
            // later
            // RectButton(
            //   margin: unifyMargin,
            //   color: Theme.of(context).accentColor,
            //   elevation: 3,
            //   onPress: () => showBottomSheet(context), 
            //   child: Row(
            //     children: [
            //       FlexText(
            //         alignment: Alignment.center,
            //         text: 'Add File',
            //         style: TextStyle(fontSize: 20),
            //       )
            //     ],
            //   )
            // ),
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


