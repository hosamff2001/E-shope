import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshop/shared/app_cubit/cubit.dart';
import 'package:eshop/shared/app_cubit/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopAppStats>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.GetObject(context).products != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(children: [
                CarouselSlider(
                    items: AppCubit.GetObject(context)
                        .products!
                        .data!
                        .banners
                        .map((value) => Image(
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Image.asset(
                                  "assets/images/imageerror.png",
                                  height: 100,
                                  width: 100,
                                );
                              },
                              image: NetworkImage(value.image),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ))
                        .toList(),
                    options: CarouselOptions(
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height * 0.3,
                        reverse: false,
                        initialPage: 0,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayCurve: Curves.easeInExpo)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.71,
                      children: List.generate(
                          AppCubit.GetObject(context)
                              .products!
                              .data!
                              .products
                              .length
                          ,
                          (index) => Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
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
                                              height: MediaQuery.of(context).size.width *0.4,
                                              width: MediaQuery.of(context).size.width *0.5,
                                            );
                                          },
                                          image: NetworkImage(
                                              AppCubit.GetObject(context)
                                                  .products!
                                                  .data!
                                                  .products[index]
                                                  .image as String,
                                              scale: 10),
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 200,
                                        ),
                                        if (AppCubit.GetObject(context)
                                                .products!
                                                .data!
                                                .products[index]
                                                .discount !=
                                            0)
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
                                    Text(
                                      AppCubit.GetObject(context)
                                          .products!
                                          .data!
                                          .products[index]
                                          .name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          " ${AppCubit.GetObject(context).products!.data!.products[index].price.round()} \$ ",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        if (AppCubit.GetObject(context)
                                                .products!
                                                .data!
                                                .products[index]
                                                .discount !=
                                            0)
                                          Text(
                                            " ${AppCubit.GetObject(context).products!.data!.products[index].old_price.round()} \$ ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        Spacer(),
                                        LikeButton(
                                          isLiked: AppCubit.GetObject(context)
                                                  .productsfavorites[
                                              AppCubit.GetObject(context)
                                                  .products!
                                                  .data!
                                                  .products[index]
                                                  .id],
                                          onTap: (isLiked) async {
                                            AppCubit.GetObject(context)
                                                .changefavorit(
                                                    AppCubit.GetObject(context)
                                                        .products!
                                                        .data!
                                                        .products[index]
                                                        .id);
                                            isLiked =
                                                AppCubit.GetObject(context)
                                                        .productsfavorites[
                                                    AppCubit.GetObject(context)
                                                        .products!
                                                        .data!
                                                        .products[index]
                                                        .id] as bool;
                                            
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                    ),
                  ],
                )
              ]),
            );
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
