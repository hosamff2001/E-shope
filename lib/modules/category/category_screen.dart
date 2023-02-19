import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshop/shared/app_cubit/cubit.dart';
import 'package:eshop/shared/app_cubit/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopAppStats>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
                child: ConditionalBuilder(
                    condition: state != ShopAppcategoriesloading &&
                        AppCubit.GetObject(context)
                                .categories!
                                .data!
                                .data
                                .length !=
                            null,
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                    builder: (context) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = AppCubit.GetObject(context)
                                    .categories!
                                    .data!
                                    .data[index];
                                return Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(item.image as String),
                                      fit: BoxFit.cover,
                                      height: 100,
                                    ),
                                    Text(
                                      item.name as String,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(Icons.arrow_back),
                                    )
                                  ],
                                );
                              },
                              itemCount: AppCubit.GetObject(context)
                                  .categories!
                                  .data!
                                  .data
                                  .length),
                        ))),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
