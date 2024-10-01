import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(createdAt).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (var i = 0; i < snapshot.data.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshot.data.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) => ChatBuble(
                      message: messagesList[index],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: controller,
                    onFieldSubmitted: (value) {
                      messages
                          .add({'message': value, createdAt: DateTime.now()});
                      controller.clear();
                    },
                    decoration: InputDecoration(
                        hintText: 'Send Message...',
                        suffix: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: kPrimaryColor))),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
