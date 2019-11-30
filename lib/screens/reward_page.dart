import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore _fire = Firestore.instance;

class RewardPage extends StatefulWidget {
  RewardPage({@required this.userID});
  final String userID;
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  var rewards;
  var document;

  checkIn() {
    try{
      _fire
          .collection('user')
          .where('uid', isEqualTo: widget.userID)
          .snapshots()
          .listen((data) {
        for (var data in data.documents) {
          if (mounted){
            setState((){
              rewards = data['rewards'];
              document = data.documentID;
            });
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    checkIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        rewards == null
            ? Text('')
            : Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                    Text(
                      rewards.toString(),
                    )
                  ],
                ),
              ),
        Expanded(child: StudentStream(userID: document, userRewards: this.rewards,)),
      ],
    );
  }
}

class StudentStream extends StatelessWidget {
  StudentStream({@required this.userID, @required this.userRewards});
  final String userID;
  final int userRewards;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fire.collection('rewards').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final rewards = snapshot.data.documents;
        List<RewardCards> rewardCards = [];

        for (var reward in rewards) {
          final name = reward.data['name'];
          final decription = reward.data['description'];
          final token = reward.data['token'];

          final studentCard = RewardCards(
            name: name,
            description: decription,
            token: token,
            user: userID,
            rewards: userRewards
          );
          rewardCards.add(studentCard);
        }
        return ListView(
          children: rewardCards,
        );
      },
    );
  }
}

class RewardCards extends StatelessWidget {
  RewardCards({this.name, this.description, this.token, this.user, this.rewards});
  final String name, description, user;
  final int token, rewards;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text(name)),
                content: Text('Do you want to claim this rewards?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Claims'),
                    onPressed: () {
                      _fire
                          .collection('user')
                          .document(user)
                          .updateData({
                        'rewards': rewards-token,
                      }).catchError((e) {
                        print(e);
                      });
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Rewards: $name',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 8,),
              Text(
                'Description: $description',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 8,),
              Text(
                'Coin: ${token.toString()}',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
