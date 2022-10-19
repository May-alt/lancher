import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lanherurl/layouts/data.dart';
import 'package:url_launcher/url_launcher.dart';


class lancherHome extends StatefulWidget {
  const lancherHome({Key? key}) : super(key: key);

  @override
  State<lancherHome> createState() => _lancherHomeState();
}


class _lancherHomeState extends State<lancherHome> {

  //Methode luncher url https/http
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
//Methode luncher Call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: new AppBar(
        title: Text("Lancher Url"),
      ),

      body: Column(
            children: [
              Container(
                height: 80,
                color: Colors.grey,
                child: Card(
                  child: ListTile(
                    title: Text("telephone"),
                    onTap: (){
                     _makePhoneCall("tel: 2558609");
                    },
                    leading: Icon(Icons.phone,color: Colors.blueAccent,),
                  ),
                ),
              ),


              Expanded(child: ListView(
                  children:datalansher.map((lancher) {
                    return Card(
                      child: ListTile(
                        onTap: (){
                          _launchUrl(lancher['url']);
                        },
                        title: Text(lancher['name']),
                        subtitle:  Text(lancher['url']),
                        leading: CircleAvatar(
                          child: FaIcon(
                            lancher['icons'],
                            // color: lancher['colors'],
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () => _launchUrl(lancher['url']),
                            icon: Icon(Icons.arrow_forward)
                        ),
                      ),
                    );
                  }).toList()
              ),
              ),
            ],
          ),

    );
  }



}
