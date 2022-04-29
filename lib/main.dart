import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MyHomePage(title: "Which One is More Expensive"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Stack(
            children: [
              const Text(
                'Hello',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.4,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://s3.amazonaws.com/nikeinc/assets/95620/NikeNews_FeaturedFootwear_NikeSB_DunkLowPro_BenJerrys_3_hd_1600.jpg"),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            print("Tapped on container");
          },
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.4,
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://tesla-cdn.thron.com/delivery/public/image/tesla/56cb8c41-e898-44ce-b6b7-fe9b9a05f529/bvlatuR/std/1200x628/MS-Social"),
            ),
          ),
        ),
      ],
    );
  }
}
