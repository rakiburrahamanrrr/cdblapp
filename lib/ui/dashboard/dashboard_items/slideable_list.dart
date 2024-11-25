import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:photo_view/photo_view.dart';

class SlideableImage extends StatelessWidget {
  const SlideableImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .217,
      width: size.width * .44,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: PhotoView(
                            imageProvider: NetworkImage(
                              'https://cdbl.com.bd/img/1.jpg',
                            ),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: 4.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: PhotoView(
                            imageProvider: NetworkImage(
                              'https://cdbl.com.bd/img/6.jpg',
                            ),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: 4.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: PhotoView(
                            imageProvider: NetworkImage(
                              'https://cdbl.com.bd/img/7.jpg',
                            ),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: 4.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: FullScreenWidget(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: PhotoView(
                            imageProvider: NetworkImage(
                              'https://cdbl.com.bd/img/8.jpg',
                            ),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                  // items: imageSliders,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
