import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cagnaz_apps/model.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

// ignore: must_be_immutable
class CagnazApps extends StatelessWidget {
  String appName = "";
  String desc = "";
  CagnazApps({required this.appName, required this.desc, super.key});
  Future<Model> fetchData() async {
    // Replace this URL with your API endpoint
    final response = await http
        .get(Uri.parse('https://cagnaz.com/service/api/Apps/GetMainListApps'));
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      return Model.fromJson(map);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cagnaz uygulamaları"),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.info),
              ),
              Tab(
                icon: Icon(Icons.app_shortcut),
              )
            ]),
          ),
          body: TabBarView(children: [_appInfo(), _buildAppList()]),
        ),
      ),
    );
  }

  Widget _appInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            appName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          Text(desc),
          Text("Diger uygulamalarımız tamamı yan sayfada"),
          Text(
            "Not: Uygulamalarımızdaki hiçbir veri 3. kişilerle paylaşılmamaktadır.",
          ),
        ],
      ),
    );
  }

  Padding _buildAppList() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
          future: fetchData(),
          builder: (context, AsyncSnapshot<Model> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return _buildList(snapshot);
            }
          }),
    );
  }

  ListView _buildList(AsyncSnapshot<Model> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.data!.length,
        itemBuilder: (context, i) {
          var app = snapshot.data!.data![i];
          return _buildCard(app, context);
        });
  }

  Widget _buildCard(Data app, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: 240,
              child: CarouselView(
                itemExtent: MediaQuery.sizeOf(context).width - 60,
                itemSnapping: true,
                elevation: 4,
                children: app.appImages!
                    .map((image) => Image.network(
                          image,
                          fit: BoxFit.fitHeight,
                        ))
                    .toList(),
              ),
            ),
            Text(
              app.appName ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(app.appDesc ?? ""),
            ),
            ElevatedButton(
                onPressed: () {
                  var anid = app.url?.split("=")[1];
                  if (anid != null) {
                    StoreRedirect.redirect(androidAppId: anid);
                  }
                },
                child: Text("Google Play Store"))
          ],
        ),
      ),
    );
  }
}
