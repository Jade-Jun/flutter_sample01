import 'package:flutter/material.dart';
import 'package:flutter_sample01/utils/call_and_message_service.dart';
import 'main.dart';

class Home extends StatelessWidget {
  final String phone = "123456789";
  CallsAndMessagesService _service;

  Home() {
    locator.registerSingleton(CallsAndMessagesService());
    _service = locator<CallsAndMessagesService>();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Sample Home'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(
            'images/lake.jpg',
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection(color),
          textSection
        ],
      ),
    );
  }

  Widget titleSection = Container(
    padding: EdgeInsets.all(32),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                      color: Colors.grey[500]
                  )
              )
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text('41')
      ],
    ),
  );

  Widget buttonSection(Color color) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: _buildButtonColumn(color, Icons.call, 'CALL'),
            onTap: () => _service.call(phone),
          ),
          GestureDetector(
            child: _buildButtonColumn(color, Icons.sms, "SMS"),
            onTap: () => _service.sendSms(phone),
          ),
          GestureDetector(
            child: _buildButtonColumn(color, Icons.email, "EMAIL"),
            onTap: () => _service.sendEmail("test1234@gmail.com"),
          )
        ],
      ),
    );
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );


  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color,),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}