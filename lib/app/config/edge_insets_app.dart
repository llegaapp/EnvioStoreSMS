import 'package:flutter/material.dart';
import 'responsive_app.dart';

class EdgeInsetsApp {
  // Todo
  EdgeInsetsGeometry allSmallEdgeInsets = EdgeInsets.only(left: 0, right: 0);
  EdgeInsetsGeometry allMediumEdgeInsets = EdgeInsets.only(left: 0, right: 0);
  EdgeInsets? allLargeEdgeInsets;
  EdgeInsets? allExtraLargeEdgeInsets;
  // Vertical
  EdgeInsets? vrtSmallEdgeInsets;
  EdgeInsets? vrtMediumEdgeInsets;
  EdgeInsets? vrtLargeEdgeInsets;
  EdgeInsets? vrtExtraLargeEdgeInsets;
  // Horizontal
  EdgeInsets? hrzSmallEdgeInsets;
  EdgeInsets? hrzMediumEdgeInsets;
  EdgeInsets? hrzLargeEdgeInsets;
  EdgeInsets? hrzExtraLargeEdgeInsets;

  // Solo der, izq, arriba y abajo SMALL
  EdgeInsets? onlySmallTopEdgeInsets;
  EdgeInsets? onlySmallBottomEdgeInsets;
  EdgeInsets? onlySmallRightEdgeInsets;
  EdgeInsetsGeometry onlySmallLeftEdgeInsets = EdgeInsets.only(left: 0, right: 0);


  // Solo der, izq
  EdgeInsetsGeometry onlySmallLeftRightEdgeInsets = EdgeInsets.only(left: 0, right: 0);
  EdgeInsetsGeometry onlyMediumLeftRightEdgeInsets = EdgeInsets.only(left: 0, right: 0);
  EdgeInsetsGeometry onlyLargeLeftRightEdgeInsets = EdgeInsets.only(left: 0, right: 0);
  EdgeInsets? onlyExtraLargeLeftRightEdgeInsets;

  // Solo der, izq, arriba
  EdgeInsets? onlySmallLeftRightTopEdgeInsets;
  EdgeInsetsGeometry onlyMediumLeftRightTopEdgeInsets = EdgeInsets.only(left: 0, right: 0);

  EdgeInsets? onlyLargeLeftRightTopEdgeInsets;
  EdgeInsets? onlyExtraLargeLeftRightTopEdgeInsets;


  // Solo der, izq, arriba y abajo MEDIUM
  EdgeInsets? onlyMediumTopEdgeInsets;
  EdgeInsets? onlyMediumBottomEdgeInsets;
  EdgeInsets? onlyMediumRightEdgeInsets;
  EdgeInsets? onlyMediumLeftEdgeInsets;

  // Solo der, izq, arriba y abajo LARGE
  EdgeInsets? onlyLargeTopEdgeInsets;
  EdgeInsets? onlyLargeBottomEdgeInsets;
  EdgeInsets? onlyLargeRightEdgeInsets;
  EdgeInsets? onlyLargeLeftEdgeInsets;

  EdgeInsets? onlyExtraLargeTopEdgeInsets;

  ResponsiveApp _responsiveApp;

  EdgeInsetsApp(this._responsiveApp){

    // Padding
    double _smallHeightEdgeInsets = _responsiveApp.setHeight(10);
    double _smallWidthEdgeInsets  = _responsiveApp.setWidth(10);

    double _mediumHeightEdgeInsets = _responsiveApp.setHeight(20);
    double _mediumWidthEdgeInsets  = _responsiveApp.setWidth(20);

    double _largeHeightEdgeInsets = _responsiveApp.setHeight(50);
    double _largeWidthEdgeInsets  = _responsiveApp.setWidth(50);

    double _largeExHeightEdgeInsets = _responsiveApp.setHeight(80);
    double _largeExWidthEdgeInsets  = _responsiveApp.setWidth(80);

    //Todo
    allSmallEdgeInsets   = EdgeInsets.symmetric(vertical: _smallHeightEdgeInsets, horizontal: _smallWidthEdgeInsets);
    allMediumEdgeInsets  = EdgeInsets.symmetric(vertical: _mediumHeightEdgeInsets, horizontal: _mediumWidthEdgeInsets);
    allLargeEdgeInsets   = EdgeInsets.symmetric(vertical: _largeHeightEdgeInsets, horizontal: _largeWidthEdgeInsets);
    allExtraLargeEdgeInsets = EdgeInsets.symmetric(vertical: _largeExHeightEdgeInsets, horizontal: _largeExWidthEdgeInsets);

    // Vertical 
    vrtSmallEdgeInsets  = EdgeInsets.symmetric(vertical: _smallHeightEdgeInsets);
    vrtMediumEdgeInsets = EdgeInsets.symmetric(vertical: _mediumHeightEdgeInsets);
    vrtLargeEdgeInsets  = EdgeInsets.symmetric(vertical: _largeHeightEdgeInsets);    
    vrtExtraLargeEdgeInsets = EdgeInsets.symmetric(vertical: _largeExHeightEdgeInsets);
    
    // Horizontal
    hrzSmallEdgeInsets  = EdgeInsets.symmetric(horizontal: _smallWidthEdgeInsets);
    hrzMediumEdgeInsets = EdgeInsets.symmetric(horizontal: _mediumWidthEdgeInsets);
    hrzLargeEdgeInsets  = EdgeInsets.symmetric(horizontal: _largeWidthEdgeInsets);    
    hrzExtraLargeEdgeInsets = EdgeInsets.symmetric(horizontal: _largeExWidthEdgeInsets);

    // Solo der, izq, arriba y abajo SMALL
    onlySmallTopEdgeInsets    = EdgeInsets.only(top: _smallHeightEdgeInsets);
    onlySmallBottomEdgeInsets = EdgeInsets.only(bottom: _smallHeightEdgeInsets);
    onlySmallRightEdgeInsets  = EdgeInsets.only(right: _smallWidthEdgeInsets);
    onlySmallLeftEdgeInsets   = EdgeInsets.only(left: _smallWidthEdgeInsets);
 
    // Solo der, izq
    onlySmallLeftRightEdgeInsets = EdgeInsets.only(left: _smallWidthEdgeInsets, right: _smallWidthEdgeInsets);    
    onlyMediumLeftRightEdgeInsets = EdgeInsets.only(left: _mediumWidthEdgeInsets, right: _mediumWidthEdgeInsets);    
    onlyLargeLeftRightEdgeInsets = EdgeInsets.only(left: _largeWidthEdgeInsets, right: _largeWidthEdgeInsets);        
    onlyExtraLargeLeftRightEdgeInsets = EdgeInsets.only(left: _largeExWidthEdgeInsets, right: _largeExWidthEdgeInsets);        

    // Solo der, izq, arriba
    onlySmallLeftRightTopEdgeInsets = EdgeInsets.only(left: _smallWidthEdgeInsets, right: _smallWidthEdgeInsets, top: _smallWidthEdgeInsets);    
    onlyMediumLeftRightTopEdgeInsets = EdgeInsets.only(left: _mediumWidthEdgeInsets, right: _mediumWidthEdgeInsets, top: _mediumWidthEdgeInsets, bottom: 10.0);    
    onlyLargeLeftRightTopEdgeInsets = EdgeInsets.only(left: _largeWidthEdgeInsets, right: _largeWidthEdgeInsets, top: _largeWidthEdgeInsets);        
    onlyExtraLargeLeftRightTopEdgeInsets = EdgeInsets.only(left: _largeExWidthEdgeInsets, right: _largeExWidthEdgeInsets, top: _largeExWidthEdgeInsets);        


    // Solo der, izq, arriba y abajo SMALL
    onlyMediumTopEdgeInsets    = EdgeInsets.only(top: _mediumHeightEdgeInsets);
    onlyMediumBottomEdgeInsets = EdgeInsets.only(bottom: _mediumHeightEdgeInsets);
    onlyMediumRightEdgeInsets  = EdgeInsets.only(right: _mediumWidthEdgeInsets);
    onlyMediumLeftEdgeInsets   = EdgeInsets.only(left: _mediumWidthEdgeInsets);

    // Solo der, izq, arriba y abajo LARGE 
    onlyLargeTopEdgeInsets    = EdgeInsets.only(top: _largeHeightEdgeInsets);
    onlyLargeBottomEdgeInsets = EdgeInsets.only(bottom: _largeHeightEdgeInsets);
    onlyLargeRightEdgeInsets  = EdgeInsets.only(right: _largeWidthEdgeInsets);
    onlyLargeLeftEdgeInsets   = EdgeInsets.only(left: _largeWidthEdgeInsets);
  
    onlyExtraLargeTopEdgeInsets = EdgeInsets.only(top: _largeExHeightEdgeInsets);
  }
}