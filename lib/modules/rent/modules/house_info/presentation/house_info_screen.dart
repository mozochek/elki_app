import 'package:cached_network_image/cached_network_image.dart';
import 'package:elki_app/modules/core/presentation/l10n/app_localizations.dart';
import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:elki_app/modules/rent/domain/entity/house_info_entity.dart';
import 'package:elki_app/modules/rent/presentation/widgets/house_rent_price_widget.dart';
import 'package:elki_app/modules/rent/presentation/widgets/house_type_and_location_widget.dart';
import 'package:elki_app/modules/rent/presentation/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class HouseInfoScreen extends StatelessWidget {
  final HouseInfoEntity houseInfo;

  const HouseInfoScreen({
    required this.houseInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appTheme = AppTheme.of(context);
    final textTheme = appTheme.textTheme;
    final colorsScheme = appTheme.colorsScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: HouseTypeAndLocationWidget(
                  type: houseInfo.type,
                  location: houseInfo.location,
                ),
              ),
              SizedBox(
                height: 264.0,
                child: houseInfo.haveImages
                    ? PageView.builder(
                        itemCount: houseInfo.imageUrls.length,
                        itemBuilder: (context, index) {
                          final image = houseInfo.imageUrls[index];

                          return CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.fill,
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
                child: Text(
                  houseInfo.description.isEmpty ? l10n.descriptionIsMissing : houseInfo.description,
                  style: textTheme.commonText.copyWith(
                    color: colorsScheme.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFF433175).withOpacity(0.15),
              offset: const Offset(.0, -9.0),
              blurRadius: 16.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              HouseRentPriceWidget(price: houseInfo.dailyPrice),
              const SizedBox(width: 10.0),
              Expanded(
                child: RoundedButton(
                  text: l10n.back,
                  onTap: () => Navigator.maybePop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
