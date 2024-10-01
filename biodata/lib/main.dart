import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['title'] = 'nice';
    biodata['name'] = 'Chisato';
    biodata['image'] = 'bg.png';
    biodata['show'] = 'lycoris';
    biodata['desc'] = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
  }

  Future launch(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil : $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aplikasi Biodata",
      home: Scaffold(
        appBar: AppBar(title: const Text("Aplikasi Biodata")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,

                decoration: const BoxDecoration(color: Colors.black),
                child: Text(
                  biodata['title'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Image(image: AssetImage('assets/${biodata["image"] ?? ''}')),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      btnContact(Icons.alternate_email, Colors.green[900],'/'),
                      btnContact(Icons.mark_email_read, Colors.blueAccent,'/'),
                      btnContact(Icons.phone, Colors.deepPurple,'/'),
                    ],
                  ),
                ],
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  textAttribute('Who ?', biodata['name'] ?? ''),
                  textAttribute('What ?', biodata['show'] ?? ''),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  teksKotak(Colors.black, biodata['name'] ?? ''),
                  const SizedBox(
                    height: 10,
                  ),
                  teksKotak(Colors.black38, 'More'),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Text(
                    biodata['desc'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded btnContact(IconData icon, var color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launchUrl(Uri.parse(uri));
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: color,
          foregroundColor: Colors.white
        ),
        child: Icon(icon),
      ),
    );
  }

  Row textAttribute(String judul, String teks) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '- $judul ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(fontSize: 18),
        ),
        Text(
          teks,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Container teksKotak(Color bgColor, String teks) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }

}
