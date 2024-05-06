import 'package:flutter/material.dart';
import 'package:frontend_app/models/datapoint.dart';
import 'package:frontend_app/services/api_service.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  _DataViewState createState() => _DataViewState();
}
class _DataViewState extends State<DataView> {

  late List<DataPoint>? datapoints = [];
  //const DataView({super.key});
  @override
  void initState() {
    super.initState();
    _getUserData(); 
  }

  void _getUserData() async {
    datapoints = (await ApiService().getUserData(12))!;
    print(datapoints);
    setState(() {});
    // DataPoint p = DataPoint(userId: 12, name: "weight", value: 12, collectionDate: DateTime.now(), collectionType: CollectionType.manual);

    // bool? success = await ApiService().putData(12, p);
    // log(success! ? "successfully added" : "no");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Data View"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: (datapoints == null || datapoints!.isEmpty)
      ? const Center(
        child: CircularProgressIndicator(
        ),
      )
      : ListView.builder(
        itemCount: datapoints!.length,
        itemBuilder: ((context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${datapoints![index].name.toString()}:"),
                    Text(datapoints![index].value.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Collected at ${datapoints![index].collectionDate.toString()}"),
                    //Text("collection type: ${datapoints![index].collectionType}"),
                  ],
                )
              ]
            )
          );
        })
      )
        // Text('Details and data visualization stuff.', style: TextStyle(fontSize: 16)),
    );
  }
}
