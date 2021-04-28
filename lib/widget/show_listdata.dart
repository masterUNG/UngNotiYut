import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ungnoti/models/food_model.dart';
import 'package:ungnoti/utility/my_constant.dart';
import 'package:ungnoti/widget/show_progress.dart';

class ShowListData extends StatefulWidget {
  @override
  _ShowListDataState createState() => _ShowListDataState();
}

class _ShowListDataState extends State<ShowListData> {
  bool load = true;
  List<FoodModel> foodModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    String urlAPI = '${MyConstant.domain}/fluttertraining/getAllFood.php';
    await Dio().get(urlAPI).then((value) {
      // print('value => $value');

      for (var item in json.decode(value.data)) {
        FoodModel model = FoodModel.fromMap(item);
        setState(() {
          foodModels.add(model);
        });
      }

      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : ListView.builder(
              itemCount: foodModels.length,
              itemBuilder: (context, index) => Card(color: index%2 == 0 ? Colors.green : Colors.white ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              foodModels[index].nameFood,
                              style: GoogleFonts.charm(
                                textStyle: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(foodModels[index].price),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(foodModels[index].price),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 200,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${MyConstant.domain}${foodModels[index].image}',
                                placeholder: (context, url) => ShowProgress(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(MyConstant.authen),
                              ),
                            ),
                          ),
                          Expanded(child: Text(foodModels[index].detail))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
