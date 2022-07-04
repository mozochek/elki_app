import 'package:cached_network_image/cached_network_image.dart';
import 'package:elki_app/modules/core/presentation/l10n/app_localizations.dart';
import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:elki_app/modules/rent/domain/entity/house_type.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/available_houses_screen_scope.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/bloc/available_houses_data_bloc.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/bloc/available_houses_filter_bloc.dart';
import 'package:elki_app/modules/rent/modules/house_info/presentation/house_info_screen.dart';
import 'package:elki_app/modules/rent/presentation/widgets/house_rent_price_widget.dart';
import 'package:elki_app/modules/rent/presentation/widgets/house_type_and_location_widget.dart';
import 'package:elki_app/modules/rent/presentation/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableHousesScreen extends StatelessWidget {
  const AvailableHousesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvailableHousesScreenScope(
      child: Scaffold(
        appBar: const HouseTypeSelectorAppBar(),
        body: SafeArea(
          child: BlocBuilder<AvailableHousesDataBloc, AvailableHousesDataState>(
            builder: (context, state) {
              return state.map<Widget>(
                notInitialized: (_) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (state) {
                  return _ErrorWidget(reason: state.reason);
                },
                data: (state) {
                  final housesInfoList = state.dataToDisplay;

                  return ListView.separated(
                    itemCount: housesInfoList.length,
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                    itemBuilder: (context, index) {
                      final houseInfo = housesInfoList[index];

                      Widget child = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: HouseInfoCard(
                          houseInfo: houseInfo,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HouseInfoScreen(houseInfo: houseInfo),
                              ),
                            );
                          },
                        ),
                      );

                      if (index == 0) {
                        child = Column(
                          children: <Widget>[
                            const SizedBox(height: 16.0),
                            child,
                          ],
                        );
                      }

                      if (index == housesInfoList.length - 1) {
                        child = Column(
                          children: <Widget>[
                            child,
                            const SizedBox(height: 16.0),
                          ],
                        );
                      }

                      return child;
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class HouseTypeSelectorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HouseTypeSelectorAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(52.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 52.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const <Widget>[
              SizedBox(width: 16.0),
              AllHousesTypeButton(),
              SizedBox(width: 8.0),
              OFrameTypeButton(),
              SizedBox(width: 8.0),
              AFrameTypeButton(),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

class AllHousesTypeButton extends StatelessWidget {
  const AllHousesTypeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HouseTypeButton(
      type: null,
      onTap: () => AvailableHousesScreenScope.resetHouseType(context),
    );
  }
}

class OFrameTypeButton extends StatelessWidget {
  const OFrameTypeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HouseTypeButton(
      type: HouseType.oFrame,
      onTap: () => AvailableHousesScreenScope.setHouseTypeFilter(context, HouseType.oFrame),
    );
  }
}

class AFrameTypeButton extends StatelessWidget {
  const AFrameTypeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HouseTypeButton(
      type: HouseType.aFrame,
      onTap: () => AvailableHousesScreenScope.setHouseTypeFilter(context, HouseType.aFrame),
    );
  }
}

class _HouseTypeButton extends StatelessWidget {
  final HouseType? type;
  final VoidCallback onTap;

  const _HouseTypeButton({
    required this.type,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final colorsScheme = appTheme.colorsScheme;

    return BlocBuilder<AvailableHousesFilterBloc, AvailableHousesFilterState>(
      buildWhen: (prev, curr) {
        final prevType = prev.filter.type;
        final currType = curr.filter.type;

        return prevType != currType && (prevType == type || currType == type);
      },
      builder: (context, state) {
        final isSelected = state.filter.type == type;

        return RoundedButton(
          text: _mapTypeToText(context),
          textStyle: appTheme.textTheme.commonText.copyWith(
            color: isSelected ? colorsScheme.white : colorsScheme.black,
          ),
          onTap: onTap,
          color: isSelected ? colorsScheme.primary : colorsScheme.beige,
          borderRadius: const BorderRadius.all(
            Radius.circular(19.0),
          ),
          textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        );
      },
    );
  }

  String _mapTypeToText(BuildContext context) {
    if (type == null) return AppLocalizations.of(context).allHouses.toLowerCase();

    return type!.toL10n(context);
  }
}

class _ErrorWidget extends StatelessWidget {
  final String reason;

  const _ErrorWidget({
    required this.reason,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);

    return Center(
      child: Text(
        _mapReasonToL10n(context),
        style: appTheme.textTheme.commonText.copyWith(
          color: appTheme.colorsScheme.black,
        ),
      ),
    );
  }

  String _mapReasonToL10n(BuildContext context) {
    switch (reason) {
      default:
        return AppLocalizations.of(context).errorHasOccurred;
    }
  }
}

class HouseInfoCard extends StatelessWidget {
  final HouseInfoEntity houseInfo;
  final VoidCallback onTap;

  const HouseInfoCard({
    required this.houseInfo,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appTheme = AppTheme.of(context);
    final textTheme = appTheme.textTheme;
    final colorsScheme = appTheme.colorsScheme;

    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2.0,
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 264.0,
                child: houseInfo.haveImages
                    ? CachedNetworkImage(
                        imageUrl: houseInfo.previewImage!,
                        fit: BoxFit.fitHeight,
                        errorWidget: (context, _, __) {
                          return Center(
                            child: Text(
                              l10n.failedToGetImage,
                              style: textTheme.commonText.copyWith(
                                color: colorsScheme.black,
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          l10n.noImages,
                          style: textTheme.commonText.copyWith(
                            color: colorsScheme.black,
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HouseTypeAndLocationWidget(
                      type: houseInfo.type,
                      location: houseInfo.location,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        _HouseRatingAndReviews(
                          rating: houseInfo.rating,
                          reviewsCount: houseInfo.reviewsCount,
                        ),
                        const Expanded(
                          child: SizedBox(width: 16.0),
                        ),
                        HouseRentPriceWidget(
                          price: houseInfo.dailyPrice,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HouseRatingAndReviews extends StatelessWidget {
  final int rating;
  final int reviewsCount;

  const _HouseRatingAndReviews({
    required this.rating,
    required this.reviewsCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final textTheme = appTheme.textTheme;
    final colorsScheme = appTheme.colorsScheme;

    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Row(
              children: <Widget>[
                ...List.generate(
                  5,
                  (index) {
                    final resolvedColor = rating >= index ? colorsScheme.primary : colorsScheme.grey;

                    return Icon(
                      Icons.star,
                      size: 12.0,
                      color: resolvedColor,
                    );
                  },
                ),
              ],
            ),
          ),
          const WidgetSpan(
            child: SizedBox(width: 4.0),
          ),
          TextSpan(
            text: '(${AppLocalizations.of(context).reviewsPlural(reviewsCount)})',
            style: textTheme.smallText.copyWith(
              color: colorsScheme.black,
            ),
          ),
        ],
      ),
    );
  }
}
