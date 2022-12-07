import 'dart:math';
import 'dart:typed_data';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

@MappableClass()
class Note {
  @MappableField(key: "i")
  final String id;
  @MappableField(key: "n")
  final String name;
  @MappableField(key: "0")
  final String? parentId;
  @MappableField(key: "c")
  final DateTime creationTime;
  @MappableField(key: "e")
  final DateTime lastEditTime;
  @MappableField(key: "p")
  final List<PaintElement> paintElements;
  @MappableField(key: "t")
  final List<TextElement> textElements;
  @MappableField(key: "i")
  final Map<String, ImageElement> imageElements;

  const Note(
      {required this.id,
      required this.name,
      this.parentId,
      required this.creationTime,
      required this.lastEditTime,
      required this.paintElements,
      required this.textElements,
      required this.imageElements});

  Note copy({
    String? name,
    String? parentId,
    DateTime? creationTime,
    DateTime? lastEditTime,
    List<PaintElement>? paintElements,
    List<TextElement>? textElements,
    Map<String, ImageElement>? imageElements
  }) => Note(
    id: id,
    name: name ?? this.name,
    parentId: (parentId == "null") ? null : (parentId ?? this.parentId),
    creationTime: creationTime ?? this.creationTime,
    lastEditTime: lastEditTime ?? this.lastEditTime,
    paintElements: paintElements ?? this.paintElements,
    textElements: textElements ?? this.textElements,
    imageElements: imageElements ?? this.imageElements
  );

  Note replaceImage(
    String id,
    ImageElement newImage
  ) => copy(
    imageElements: Map.castFrom<dynamic, dynamic, String, ImageElement>(imageElements.copy()).map((key, value) => MapEntry(key, (key == id) ? newImage : value))
  );

  Note removeImage(
    String id
  ) {
    final imgs = Map.castFrom<dynamic, dynamic, String, ImageElement>(imageElements.copy());
    imgs.remove(id);
    return copy(
      imageElements: imgs
    );
  }

  Note addImage(
    ImageElement image
  ) {
    final imgs = Map.castFrom<dynamic, dynamic, String, ImageElement>(imageElements.copy());
    imgs[image.id] = image;
    return copy(
      imageElements: imgs
    );
  }

  Note moveImage(
    String id,
    num x,
    num y
  ) => replaceImage(id, imageElements[id]!.copy(relX: x, relY: y));

  Note replacePainting(
    int index,
    PaintElement newPainting
  ) => copy(
    paintElements: paintElements.asMap().map((key, value) => MapEntry(key, (key == index) ? newPainting : value)).values.toList()
  );
}

@MappableClass()
class PaintElement {
  @MappableField(key: "p")
  final List<Point> points;
  @MappableField(key: "n")
  final int pageNum;
  @MappableField(key: "t")
  final num thickness;
  @MappableField(key: "c")
  final Color color;
  @MappableField(key: "l")
  final PenType penType;

  const PaintElement(
      {required this.points,
      required this.color,
      required this.penType,
      required this.thickness,
      required this.pageNum});
  
  PaintElement copy({
    List<Point>? points,
    Color? color,
    PenType? penType,
    num? thickness,
    int? pageNum
  }) => PaintElement(
    points: points ?? this.points,
    color: color ?? this.color,
    penType: penType ?? this.penType,
    thickness: thickness ?? this.thickness,
    pageNum: pageNum ?? this.pageNum
  );
}

@MappableEnum()
enum PenType { pen, graphitPen }

@MappableClass()
class TextElement {
  @MappableField(key: "t")
  final String text;
  @MappableField(key: "b")
  final bool bold;
  @MappableField(key: "i")
  final bool italic;
  @MappableField(key: "u")
  final bool superscript;
  @MappableField(key: "d")
  final bool subscript;
  @MappableField(key: "s")
  final int fontSize;
  @MappableField(key: "c")
  final Color? fontColor;

  const TextElement(
      {required this.text,
      required this.bold,
      required this.italic,
      required this.superscript,
      required this.subscript,
      required this.fontSize,
      this.fontColor});

  const TextElement.fromText(this.text,
      {this.bold = false,
      this.italic = false,
      this.superscript = false,
      this.subscript = false,
      this.fontSize = 14,
      this.fontColor});
  
  static compileToRichText(List<TextElement> textElements) {
    return Text.rich(
      TextSpan(
        children: textElements.map((e) => TextSpan(
          text: e.text,
          style: TextStyle(
            fontWeight: (e.bold) ? FontWeight.bold : null,
            fontSize: e.fontSize.toDouble(),
            fontStyle: (e.italic) ? FontStyle.italic : null,
            color: e.fontColor
          )
        )).toList()
      )
    );
  }

  TextElement copy({
    String? text,
    bool? bold,
    bool? italic,
    bool? superscript,
    bool? subscript,
    int? fontSize,
    Color? fontColor
  }) => TextElement(
    text: text ?? this.text,
    bold: bold ?? this.bold,
    italic: italic ?? this.italic,
    superscript: superscript ?? this.superscript,
    subscript: subscript ?? this.subscript,
    fontSize: fontSize ?? this.fontSize,
    fontColor: fontColor ?? this.fontColor
  );
}

@MappableClass()
class ImageElement {
  // final PicAlignment alignment;
  @MappableField(key: "i")
  final String id;
  @MappableField(key: "d")
  final Uint8List imageData;
  @MappableField(key: "x")
  final num relX;
  @MappableField(key: "y")
  final num relY;
  @MappableField(key: "n")
  final int pageNum;
  @MappableField(key: "w")
  final num width;
  @MappableField(key: "h")
  final num height;

  ImageElement(
      {required this.id,
      required this.imageData,
      required this.relX,
      required this.relY,
      required this.pageNum,
      required this.width,
      required this.height});
  
  ImageElement copy({
    Uint8List? imageData,
    num? relX,
    num? relY,
    int? pageNum,
    num? width,
    num? height
  }) => ImageElement(
    id: id,
    imageData: imageData ?? this.imageData,
    relX: relX ?? this.relX,
    relY: relY ?? this.relY,
    pageNum: pageNum ?? this.pageNum,
    width: width ?? this.width,
    height: height ?? this.height
  );
}

// enum PicAlignment {
//   textAround,
//   noTextAround,
//   freeOnPage
// }

extension Copier on Map {
  dynamic copy() {
    return map((key, value) => MapEntry(key, value));
  }
}