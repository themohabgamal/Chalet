import 'package:cached_network_image/cached_network_image.dart';
import 'package:chalet_spot/core/utils/app_colors.dart';
import 'package:chalet_spot/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:chalet_spot/core/api/dio_consumer.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_cubit.dart';
import 'package:chalet_spot/features/owner/home/presentation/manager/cubit/owner_state.dart';

class OwnerSingleChalet extends StatelessWidget {
  final String chaletId;

  const OwnerSingleChalet({super.key, required this.chaletId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OwnerCubit(DioConsumer(dio: Dio()))..getChaletDetails(chaletId),
      child: BlocBuilder<OwnerCubit, OwnerState>(
        builder: (context, state) {
          if (state is OwnerLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is OwnerSingleChaletLoaded) {
            final chalet = state.chalet;

            return Scaffold(
              appBar: AppBar(
                title: Text(chalet.name),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the first image in a square aspect ratio
                      if (chalet.imgs.isNotEmpty)
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: chalet.imgs.first.img,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorWidget: (context, url, error) {
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 16.0),
                      Text(
                        chalet.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'المدينة: ${chalet.city}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'العنوان: ${chalet.address}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'الوصف',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(chalet.description),
                      const SizedBox(height: 16.0),
                      Text(
                        'المميزات',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      ...chalet.features.map((feature) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(feature.title),
                            subtitle:
                                Text(feature.description ?? 'لا يوجد وصف'),
                            leading:
                                const Icon(Icons.star, color: Colors.amber),
                          )),
                      const SizedBox(height: 16.0),
                      Text(
                        'الأسعار',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      ...chalet.prices.map((price) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('${price.stayType} إقامة'),
                            subtitle: Text('\$${price.price}'),
                            leading: const Icon(Icons.attach_money,
                                color: Colors.green),
                          )),
                      const SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.lightGreen,
                              ),
                              onPressed: () {
                                // Navigate to update page
                                Navigator.pushNamed(context, '/updateChalet',
                                    arguments: chaletId);
                              },
                              child: Text(
                                'تحديث الشاليه',
                                style: TextStyles.poppins18w500(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is OwnerError) {
            return Center(child: Text(state.error.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
