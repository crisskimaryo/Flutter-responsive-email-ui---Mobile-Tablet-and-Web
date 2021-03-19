import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:outlook/constants.dart';
import 'package:outlook/models/category_model.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:outlook/services/category._service.dart';

typedef void AddSpecialityCallback(List result);

class AddSpeciality extends StatefulWidget {
  final AddSpecialityCallback onSubmit;
  final CategoryModel category;
  final ExpertModel expert;
  AddSpeciality(
      {this.onSubmit, @required this.category, @required this.expert});

  @override
  _AddSpecialityState createState() => _AddSpecialityState();
}

class _AddSpecialityState extends State<AddSpeciality> {
  List value = [];
  List<CategoryModel> _listSpecialist = [];
  //  List<CategoryModel>_listViewData = [];
  List<CategoryModel> __listSpecialistOrginal = [];
  Future<List<CategoryModel>> _futureSubcatergory;
  @override
  initState() {
    super.initState();
    //
    _futureSubcatergory = loadData();
  }

  //
  Future<List<CategoryModel>> loadData() async {
    var resData = await CategoryService()
        .subcategoriesListByCatID({"catId": widget.category.id}, context);
    // print(resData);
    if (resData == []) {
      setState(() {
        __listSpecialistOrginal = null;
        _listSpecialist = null;
      });
    }
    resData.forEach((doc) => {
          setState(() {
            _listSpecialist.add(CategoryModel.fromDoc(doc));
            __listSpecialistOrginal.add(CategoryModel.fromDoc(doc));
          })
        });
    return __listSpecialistOrginal;
  }

  TextEditingController controller = new TextEditingController();

  onSearchTextChanged(String text) async {
    print(text);
    print(text);
    // _searchResult.clear();
    if (text.isEmpty) {
      setState(() {
        _listSpecialist = __listSpecialistOrginal;
      });
      return;
    }

    setState(() {
      _listSpecialist = _listSpecialist
          .where((d) => d.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '${widget.category.name}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Center(
              child: Text(
            'Select Services',
            style: TextStyle(fontSize: 12),
          )),
          SizedBox(
            height: 10,
          ),
          __listSpecialistOrginal != null && __listSpecialistOrginal.isNotEmpty
              ? TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintStyle: TextStyle(fontSize: 13),
                      hintText: 'Search services',
                      border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                )
              : Container(),
          Divider()
        ],
      ),
      content: Container(
        width: double.maxFinite,
        // height: 310.0,
        child: FutureBuilder<List<CategoryModel>>(
            future: _futureSubcatergory,
            // initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              // print(snapshot.data);
              // return Text('data');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                );
              }

              if (snapshot.data.isEmpty) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      child: Text(
                        "No services Availlable ,  \n please contact feitango to fix this.",
                        // style: textHeader,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }
              return ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    ..._listSpecialist
                        .map(
                          (val) => Column(
                            children: <Widget>[
                              CheckboxListTile(
                                value: value.contains(val.id),
                                title: new Text(val.name),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                activeColor: Colors.lightBlueAccent,
                                onChanged: (bool selected) {
                                  print(selected);
                                  _onCategorySelected(
                                    selected,
                                    val.id,
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                        .toList()
                  ]);
            }),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('CANCEL', style: TextStyle(color: Colors.redAccent)),
          onPressed: () {
            if (!isLoading) Navigator.pop(context);
          },
        ),
        FlatButton(
          child: isLoading == false
              ? Text(
                  'OK',
                  style: TextStyle(color: kPrimaryColor),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
          onPressed: value.isEmpty
              ? null
              : () async {
                  BotToast.showLoading();
                  try {
                    print('hi id ${widget.expert.id.toString()}');
                    print(widget.expert.id);
                    await CategoryService()
                        .updatecategoryExpert(widget.expert, value, 'add');
                    widget.onSubmit(value);
                    BotToast.closeAllLoading();
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                    BotToast.closeAllLoading();
                    showToast(
                      "${e.toString()}",
                      backgroundColor: Colors.red,
                      textStyle:
                          TextStyle(color: Colors.black26, fontSize: 16.0),
                    );
                    // Fluttertoast.showToast(
                    //     msg: "${e.toString()}",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.TOP,
                    //     timeInSecForIosWeb: 5,
                    //     backgroundColor: Colors.red,
                    //     textColor: Colors.black26,
                    //     fontSize: 16.0);
                  }
                },
        )
      ],
    );
  }

  void _onCategorySelected(bool selected, val) {
    print(selected);
    if (selected == true) {
      setState(() {
        value.add(val);
      });
    } else {
      setState(() {
        value.remove(val);
      });
    }

    print(value);
  }
}
