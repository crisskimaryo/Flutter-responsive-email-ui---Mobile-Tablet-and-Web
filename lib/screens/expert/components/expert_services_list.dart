import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:outlook/components/dialogyComp.dart';
import 'package:outlook/constants.dart';
import 'package:outlook/models/category_model.dart';
import 'package:outlook/models/expert_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outlook/screens/catergories/main_category_widget.dart';
import 'package:outlook/services/category._service.dart';

class ServiceCatergoriesScreen extends StatelessWidget {
  final ExpertModel expert;

  const ServiceCatergoriesScreen({Key key, this.expert}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> _categories = [];
    expert.categories
        .forEach((doc) => {_categories.add(CategoryModel.fromDoc(doc))});

    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('My Specialization :'),
            IconButton(
              color:
                  expert.categories.length > 15 ? Colors.grey : kPrimaryColor,
              icon: Icon(Icons.add),
              onPressed: () {
                if (expert.categories.length > 15) {
                  Fluttertoast.showToast(
                      msg:
                          "You have reach ${expert.categories.length} maximum specialization",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 10,
                      backgroundColor: kPrimaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  // MainCatergoryListWiget
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MainCatergoryListWiget(expert: expert),
                    ),
                  );
                }
              },
            )
          ],
        ),

        Tags(
          itemCount: expert.categories.length,
          alignment: WrapAlignment.start,
          // columns: 1,
          // horizontalScroll: true,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,

          // required
          itemBuilder: (int index) {
            final item = _categories;
            // deloading.add(false);
            return ItemTags(
              splashColor: null,
              highlightColor: null,
              // removeButton: ItemTagsRemoveButton(color: Colors.redAccent),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              onPressed: (val) {
                {
                  // Remove the item from the data source.
                  showDialog(
                      context: context,
                      builder: (context) => DialogyComp(
                          title: 'Confirm Deleting',
                          desc: 'Click “OK” to delete "${item[index].name}"',
                          buttonlabel: 'OK',
                          onSubmit: (re) async =>
                              {_deleteSpecialization(item[index], index)}));
                  //required

                }
              },
              // pressEnabled: false,
              // elevation: 1.0,
              active: false,
              activeColor: Colors.white,
              // color: deloading[index] == true ? Colors.redAccent : Colors.white,
              textColor: Colors.black,
              textActiveColor: Colors.black,
              // Each ItemTags must contain a Key. Keys allow Flutter to
              // uniquely identify widgets.
              key: Key(index.toString()),
              index: index, // required
              title: item[index].name,
              // active: item.active,
              // customData: item.customData,
              textStyle: TextStyle(
                fontSize: 12,
              ),
              combine: ItemTagsCombine.withTextBefore,
              borderRadius: BorderRadius.zero,
              textOverflow: TextOverflow.ellipsis,
              // image: ItemTagsImage(
              //     image: AssetImage(
              //         "img.jpg") // OR NetworkImage("https://...image.png")
              //     ), // OR null,

              //  deloading[index] == false
              //     ? IconButton(
              //         icon: Icon(Icons.delete),)
              // icon: deloading[index] == false
              //     ? ItemTagsIcon(
              //         icon: Icons.delete,
              //       )
              //     : ItemTagsIcon(
              //         icon: Icons.swap_vertical_circle,
              //       ), // OR null,
              removeButton: ItemTagsRemoveButton(
                icon: Icons.delete,
                onRemoved: () {
                  // Remove the item from the data source.
                  showDialog(
                      context: context,
                      builder: (context) => DialogyComp(
                          title: 'Confirm Deleting',
                          desc: 'Click “OK” to delete "${item[index].name}"',
                          buttonlabel: 'OK',
                          onSubmit: (re) async =>
                              {_deleteSpecialization(item[index], index)}));
                  //required
                  return true;
                },
              ), // OR null,
              // onPressed: (item) => print(item),
              // onLongPressed: (item) => print(item),
            );
          },
        ),

        // Text('${_categories.toList()}'),
        _categories.length < 1
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.black12.withOpacity(.1),
                child: Center(
                    child: Text(
                        "no specialization selected , \n click the above + button")))
            : Container(),
        Container(
          height: 20,
        )
      ],
    );
  }

  _deleteSpecialization(CategoryModel c, index) async {
    // print(c.name);
    BotToast.showLoading();
    try {
      await CategoryService().updatecategoryExpert(expert, [c.key], 'remove');
      BotToast.closeAllLoading();
    } catch (e) {
      BotToast.closeAllLoading();
      print(e);
      print('eror ---------------------------');
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.black26,
          fontSize: 16.0);
    }
  }
}
