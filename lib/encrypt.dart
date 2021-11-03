import 'package:flutter/material.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({Key? key}) : super(key: key);

  @override
  _EncryptPageState createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  
  String? _string, _encryptedString;

  int? _previousRune;
  int? _previousRuneCount;

  void _encrypt(String? string) {
    _encryptedString = '';
    _previousRune = null;
    _previousRuneCount = 0;

    string?.runes.forEach((rune) {
      var character = String.fromCharCode(rune);

      if (_previousRune != null && _previousRune == rune) {
        setState(() {
          _previousRune = rune;
          _previousRuneCount = (_previousRuneCount ?? 0) + 1;

          _encryptedString = _encryptedString!
                  .substring(0, _encryptedString!.length - 1) +
              (_previousRuneCount != 0 ? _previousRuneCount.toString() : '0');
        });
      } else {
        setState(() {
          _previousRune = rune;
          _previousRuneCount = 1;
          _encryptedString = _encryptedString! + character + '1';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black,
          title:  Text('Encrypt String'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                
                style: TextStyle(color: Colors.white),
                decoration:  InputDecoration(
                  
                  labelText: 'Enter String',
                  labelStyle: TextStyle(color: Colors.white,),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white),
                  
                  ),
                focusedBorder:UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  ),
                
                onChanged: (value) {
                  setState(() {
                    _string = value;
                  });
                },
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(height: 50,width: 300,
              child: ElevatedButton(
                child: const Text('Encrypt',style: TextStyle(color: Colors.white),),
                onPressed: _string == null
                    ? null
                    : () {
                        _encrypt(_string);
                      },
                         style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
               
              ),
            ),
            if (_encryptedString != null)
              Text(
                'Encrypted String: ${_encryptedString!}',
                style: const TextStyle(fontSize: 20,color: Colors.white),
              ),
              
          ],
        ),
      ),
    );
  }
}