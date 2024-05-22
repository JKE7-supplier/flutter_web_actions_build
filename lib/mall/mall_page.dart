import 'package:flutter/material.dart';
import 'package:flutter_web_actions_build/mall/services/mall_response.dart';
import 'package:flutter_web_actions_build/mall/themes/mulan_colors.dart';
import 'package:flutter_web_actions_build/mall/viewmodels/mall_view_model.dart';
import 'package:flutter_web_actions_build/mall/widgets/mall_list_item_widget.dart';
import 'package:flutter_web_actions_build/mall/widgets/tabbar_widget.dart';
import 'package:flutter_web_actions_build/viewmodel/viewmodel_provider.dart';
import 'package:flutter_web_actions_build/widgets/text_widget.dart';

class MallPage extends StatefulWidget {
  static const String routeName = "/mall";

  const MallPage({Key? key}) : super(key: key);

  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  late MallViewModel _viewModel;
  late TabIndexController _indexController;

  @override
  void initState() {
    super.initState();
    _viewModel = ViewModelProvider.of(context);
    _viewModel.init(context);
    _indexController = TabIndexController();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _indexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: MulanColors.whiteSmoke,
          body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            StreamBuilder<String>(
                stream: _viewModel.titleStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return TextWidget(
                      snapshot.data as String,
                      paddingTop: 20,
                      paddingBottom: 10,
                      textColor: MulanColors.black,
                      fontSize: 20,
                    );
                  } else {
                    return Container();
                  }
                }),
            StreamBuilder<List<String>>(
                stream: _viewModel.tabNameStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data?.length == 0) {
                    return Container();
                  } else {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TabBarWidget(
                            list: snapshot.data as List<String>,
                            indexController: _indexController,
                            onTap: (index) {
                              _viewModel.changeTab(index);
                            }));
                  }
                }),
            Expanded(
              child: StreamBuilder<List<ProductEntity>>(
                stream: _viewModel.productsItemSteam.stream,
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data?.length == 0) {
                    return Container();
                  } else {
                    List<ProductEntity> products = snapshot.data as List<ProductEntity>;
                    return ListView.separated(
                        itemCount: products.length,
                        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                        itemBuilder: (BuildContext context, int index) {
                          return MallListItemWidget(product: products[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 1,
                            height: 1,
                            color: MulanColors.greyLine,
                          );
                        });
                  }
                },
              ),
            ),
          ])),
    );
  }
}
