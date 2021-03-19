import 'package:flutter/material.dart';
import 'package:outlook/constants.dart';
import 'package:outlook/models/category_model.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:outlook/screens/catergories/add_speciality.dart';
import 'package:outlook/services/category._service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainCatergoryListWiget extends StatefulWidget {
  final ExpertModel expert;

  const MainCatergoryListWiget({Key key, @required this.expert})
      : super(key: key);
  @override
  _MainCatergoryListWigetState createState() => _MainCatergoryListWigetState();
}

class _MainCatergoryListWigetState extends State<MainCatergoryListWiget> {
  List value = [];
  List<CategoryModel> _listSpecialist = [];
  List<CategoryModel> __listSpecialistOrginal = [];
  TextEditingController controller = new TextEditingController();

  @override
  initState() {
    super.initState();
// initialize
    loadData();
  }

  loadData() async {
    try {
      var resData = await CategoryService().categoriesList({}, context);
      print(resData);
      resData.forEach((doc) => {
            setState(() {
              _listSpecialist.add(CategoryModel.fromDoc(doc));
              __listSpecialistOrginal.add(CategoryModel.fromDoc(doc));
            })
          });
    } catch (e) {
      setState(() {
        __listSpecialistOrginal = null;
        _listSpecialist = null;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Categories')),
      body: Container(
          padding: EdgeInsets.all(9),
          width: double.maxFinite,
          // height: 310.0,
          child: __listSpecialistOrginal != null
              ? __listSpecialistOrginal.isNotEmpty
                  ? ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: [
                          __listSpecialistOrginal != null &&
                                  __listSpecialistOrginal.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: controller,
                                    decoration: new InputDecoration(
                                        hintText: 'Search category',
                                        border: InputBorder.none),
                                    onChanged: onSearchTextChanged,
                                  ),
                                )
                              : SizedBox.shrink(),
                          Divider(),
                          ..._listSpecialist
                              .map(
                                (val) => Column(
                                  children: <Widget>[
                                    ListTile(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AddSpeciality(
                                                  category: val,
                                                  expert: widget.expert,
                                                  onSubmit: (re) {
                                                    // setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                ));
                                      },
                                      // value: value.contains(val.id),
                                      title: new Text(val.name),
                                      trailing: Icon(MdiIcons.arrowRightBold),
                                      // controlAffinity:
                                      //     ListTileControlAffinity.leading,
                                      // activeColor: Colors.lightBlueAccent,
                                      // onChanged: (bool selected) {
                                      //   print(selected);
                                      //   _onCategorySelected(
                                      //     selected,
                                      //     val.id,
                                      //   );
                                      // },
                                    ),
                                    Divider()
                                  ],
                                ),
                              )
                              .toList()
                        ])
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    )
              : Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      child: Text(
                        "No category Availlable ,  \n please contact feitango to fix this.",
                        // style: textHeader,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )),
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
