
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmChatFriendModal extends StatefulWidget {
  final String amount;
  const AmChatFriendModal({Key? key, required this.amount}) : super(key: key);

  @override
  _AmChatFriendModalState createState() => _AmChatFriendModalState();
}

class _AmChatFriendModalState extends State<AmChatFriendModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(110, 112, 112, 1),
      height: MediaQuery.of(context).size.height * 1,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            // color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey.shade500)),
                  child: SizedBox(width: 50, child: Container())),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .65,
              child: ListView(
                children: [
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Friends on Amchat',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                  amChartFriendSearch(context),
                  const SizedBox(
                    height: 10,
                  ),
                  beneficiaryTiles(context, 'Abdullahi', '034432343', 'GTBank',
                      'https://pbs.twimg.com/profile_images/1420088013841965059/mawEI-xl_400x400.jpg'),
                  beneficiaryTiles(context, 'Abdullahi', '034432343', 'GTBank',
                      'https://pbs.twimg.com/profile_images/1420088013841965059/mawEI-xl_400x400.jpg'),
                  beneficiaryTiles(context, 'Abdullahi', '034432343', 'GTBank',
                      'https://pbs.twimg.com/profile_images/1420088013841965059/mawEI-xl_400x400.jpg'),
                  beneficiaryTiles(context, 'Abdullahi', '034432343', 'GTBank',
                      'https://pbs.twimg.com/profile_images/1420088013841965059/mawEI-xl_400x400.jpg'),
                  beneficiaryTiles(context, 'Abdullahi', '034432343', 'GTBank',
                      'https://pbs.twimg.com/profile_images/1420088013841965059/mawEI-xl_400x400.jpg')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell beneficiaryTiles(
    BuildContext context,
    String name,
    String accountNumber,
    String bank,
    String image,
  ) {
    return InkWell(
      onTap: () {
        debugPrint('call back to mainscreen');
        // push(context, Withdraw());
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
        ),
        title: Text(name),
        subtitle: Text(accountNumber + ' ' + bank),
      ),
    );
  }
}

Padding amChartFriendSearch(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Theme(
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            prefixIcon: Icon(Icons.search),
            fillColor: Color(0xFFF2F4F5),
            hintStyle: new TextStyle(color: Colors.grey[600]),
            hintText: "Search",
          ),
          autofocus: false,
        ),
        data: Theme.of(context).copyWith(
          primaryColor: Colors.grey[600],
        )),
  );
}
