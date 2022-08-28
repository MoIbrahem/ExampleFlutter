import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Chats",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 20,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: 15,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildChatCard(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildChatItem() {
  return Container(
    width: 50,
    child: Column(
      children: [
        Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green,
          )
        ]),
        SizedBox(
          height: 6,
        ),
        Text(
          "Some Name",
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget buildChatCard() {
  return Row(
    children: [
      Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"),
        ),
        CircleAvatar(
          radius: 7,
          backgroundColor: Colors.green,
        )
      ]),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Somebody Name"),
          Row(
            children: [
              Container(
                width: 190,
                child: Text(
                  "this is dumb message with toooo tooo loooong linesthis is dumb message with toooo tooo loooong linesthis is dumb message with toooo tooo loooong linesthis is dumb message with toooo tooo loooong linesthis is dumb message with toooo tooo loooong lines",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text("8:00 AM"),
            ],
          )
        ],
      ),
    ],
  );
}
