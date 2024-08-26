import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerList(double screenWidth, double screenHeight) {
  return SingleChildScrollView(
    child: Column(
      children: List.generate(
          10,
          (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: EdgeInsets.only( top: 10, bottom: 5), 
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.015),
                    width: screenWidth * 0.95, 
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.02,
                              color: Colors.grey,
                            ),
                            Container(
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.02,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: screenHeight *
                                0.01), // Spacer antara judul dan konten utama
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Container(
                                width: screenWidth *
                                    0.15, // Lebar gambar adalah 15% dari lebar layar
                                height: screenWidth *
                                    0.15, // Tinggi gambar adalah 15% dari lebar layar
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                                width: screenWidth *
                                    0.02), // Spacer antara gambar dan teks
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Vertically center the text
                              children: [
                                Container(
                                  width: screenWidth * 0.4,
                                  height: screenHeight * 0.02,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Container(
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.02,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    ),
  );
}
