import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: null,
        actions: <Widget> [
          IconButton(
            onPressed: (){
               Navigator.pushReplacementNamed(context, '/');
            }, 
            icon: const Icon(Icons.close)
            )
        ],
        title: const Text("Chat"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
            Container(
              
            )
           ]
        ),
      ),
    );
  }
}
