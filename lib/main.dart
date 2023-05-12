
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'account.dart';
import 'controller.dart';

void main() {
  runApp(GetMaterialApp(home: dashbord(), debugShowCheckedModeBanner: false));
}

class dashbord extends StatefulWidget {
  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {

  bussiness c = Get.put(bussiness());
  bool data=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello");
    c.get_account().then((value) {
      print("done");
    });
    data=true;
    print(data);
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController t = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: Text("Dashbord"),
          actions: [
            IconButton(onPressed: () => null, icon: Icon(Icons.search_rounded)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(child: Text("save as PDF")),
                PopupMenuItem(child: Text("save as Excel"))
              ],
            )
          ]),
      body: data?Obx(
            () => ListView.builder(itemCount: c.list.length,
          itemBuilder: (context, index) {
            Account a=Account.frommap(c.list.value[index]);
            return InkWell(onTap: () async {

              await Future.delayed(Duration.zero);

              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              //   return passbook(a,context);
              // },));




            },
              child: Card(
                  shadowColor: Colors.black,
                  margin: EdgeInsets.all(5),
                  child: Container(
                    height: 140,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "   ${a.name}       ${c.creditlist[index]}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            IconButton(
                                onPressed: () {
                                  t.text = a.name as String;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Update account"),
                                        actions: [
                                          TextField(
                                            controller: t,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("CANCEL")),
                                              TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                              .blue
                                                              .shade700)),
                                                  onPressed: () {
                                                    String name1 = t.text;
                                                    c.update_account(
                                                        a.id!,
                                                        name1);
                                                    Navigator.pop(context);
                                                    c
                                                        .get_account()
                                                        .then((value) {
                                                      c.temp.value = true;
                                                    });
                                                  },
                                                  child: Text(
                                                    "UPDATE",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white),
                                                  ))
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon:
                                Icon(Icons.mode_edit_outline_outlined)),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Are you sure"),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No")),
                                              TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Colors
                                                              .blue
                                                              .shade700)),
                                                  onPressed: () {
                                                    c.delete_account(
                                                        a.id!);
                                                    Navigator.pop(context);
                                                    c
                                                        .get_account()
                                                        .then((value) {
                                                      c.temp.value = true;
                                                    });
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white),
                                                  ))
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(5),
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                      "Credit(↑)\n₹${c.creditlist[index]}"),
                                )),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Text(
                                        "Debit(↓)\n₹${c.debitlist[index]}"))),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade700,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Text(
                                      "Balance\n₹${c.totallist[index]}",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  )),
            );
          },
        ),
      ):Container(),
      drawer: Drawer(
        shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(30)),
        child: Text("hello"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.deepOrangeAccent.shade700),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add new account"),
                actions: [
                  TextField(
                    controller: t,
                    decoration: InputDecoration(hintText: "Account name"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            t.text = "";
                          },
                          child: Text("CANCEL")),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.blue.shade700)),
                          onPressed: () {
                            String name = t.text;
                            c.add_account(name);
                            Navigator.pop(context);
                            t.text = "";
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
    );
  }
}
