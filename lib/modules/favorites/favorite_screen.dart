import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../../shared/app_cubit/cubit.dart';
import '../../shared/app_cubit/stats.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopAppStats>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
                child: ConditionalBuilder(
                    condition: state != ShopApploading,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    builder: (context) => ConditionalBuilder(
                          fallback: (context) => Center(
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/nofavorites.jpg"))),
                          condition: AppCubit.GetObject(context)
                                  .favoriteslist
                                  .length !=
                              0,
                          builder: (context) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var item = AppCubit.GetObject(context)
                                      .favoriteslist[index];
                                  return Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                            if (item.discount != 0)
                                              Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "discount".toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              if (item.discount != 0)
                                                Text(
                                                  " ${item.old_price.round()} \$ ",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                            
                                              
                                            ],
                                          )
                                          ,LikeButton(
                                                isLiked: AppCubit.GetObject(
                                                        context)
                                                    .productsfavorites[item.id],
                                                onTap: (isLiked) async {
                                                  AppCubit.GetObject(context)
                                                      .changefavorit(item.id);
                                                  isLiked = AppCubit.GetObject(
                                                              context)
                                                          .productsfavorites[
                                                      item.id] as bool;
                                                },
                                              ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(Icons.arrow_back),
                                      )
                                    ],
                                  );
                                },
                                itemCount: AppCubit.GetObject(context)
                                    .favoriteslist
                                    .length),
                          ),
                        ))),
          ],
        );
      },
      listener: (context, state) {},
    );
    ;
  }
}
