import 'package:eshop/modules/search/cubit/cubit.dart';
import 'package:eshop/modules/search/cubit/states.dart';
import 'package:eshop/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../shared/app_cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey globalKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(children: [
                    defaultTextFormfiled(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "enter text";
                        } else {
                          return null;
                        }
                      },
                      hint: "what do you want ?",
                      controller: searchController,
                      prefixicon: Icons.search,
                      onsubmitt: (text) {
                        SearchCubit.GetObject(context).search(text);
                      },
                    ),
                    if (state is Searchloadingstates) LinearProgressIndicator(),
                    if (state is Searchsuccessstates &&
                        SearchCubit.GetObject(context)
                            .searchdata!
                            .data!
                            .data
                            .isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var item = SearchCubit.GetObject(context)
                                  .searchdata!
                                  .data!
                                  .data[index];
            
                              return Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Image(
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              "assets/images/imageerror.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                            );
                                          },
                                          image: NetworkImage(
                                              item.image as String,
                                              scale: 10),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          item.name as String,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            " ${item.price.round()} \$ ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      LikeButton(
                                        isLiked: item.in_favorites,
                                        onTap: (isLiked) async {
                                          // AppCubit.GetObject(context)
                                          //     .changefavorit(item.id);
                                          // isLiked = AppCubit.GetObject(context)
                                          //     .productsfavorites[item.id] as bool;
                                        },
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(Icons.arrow_back),
                                  )
                                ],
                              );
                            },
                            itemCount: SearchCubit.GetObject(context)
                                .searchdata!
                                .data!
                                .data
                                .length),
                      ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
