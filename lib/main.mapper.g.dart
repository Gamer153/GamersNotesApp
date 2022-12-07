import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:dart_mappable/internals.dart';

import 'data/notes.dart';


// === ALL STATICALLY REGISTERED MAPPERS ===

var _mappers = <BaseMapper>{
  // class mappers
  NoteMapper._(),
  PaintElementMapper._(),
  TextElementMapper._(),
  ImageElementMapper._(),
  // enum mappers
  PenTypeMapper._(),
  // custom mappers
};


// === GENERATED CLASS MAPPERS AND EXTENSIONS ===

class NoteMapper extends BaseMapper<Note> {
  NoteMapper._();

  @override Function get decoder => decode;
  Note decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  Note fromMap(Map<String, dynamic> map) => Note(id: Mapper.i.$get(map, 'i'), name: Mapper.i.$get(map, 'n'), parentId: Mapper.i.$getOpt(map, '0'), creationTime: Mapper.i.$get(map, 'c'), lastEditTime: Mapper.i.$get(map, 'e'), paintElements: Mapper.i.$get(map, 'p'), textElements: Mapper.i.$get(map, 't'), imageElements: Mapper.i.$get(map, 'i'));

  @override Function get encoder => (Note v) => encode(v);
  dynamic encode(Note v) => toMap(v);
  Map<String, dynamic> toMap(Note n) => {'n': Mapper.i.$enc(n.name, 'name'), '0': Mapper.i.$enc(n.parentId, 'parentId'), 'c': Mapper.i.$enc(n.creationTime, 'creationTime'), 'e': Mapper.i.$enc(n.lastEditTime, 'lastEditTime'), 'p': Mapper.i.$enc(n.paintElements, 'paintElements'), 't': Mapper.i.$enc(n.textElements, 'textElements'), 'i': Mapper.i.$enc(n.imageElements, 'imageElements')};

  @override String stringify(Note self) => 'Note(id: ${Mapper.asString(self.id)}, name: ${Mapper.asString(self.name)}, parentId: ${Mapper.asString(self.parentId)}, creationTime: ${Mapper.asString(self.creationTime)}, lastEditTime: ${Mapper.asString(self.lastEditTime)}, paintElements: ${Mapper.asString(self.paintElements)}, textElements: ${Mapper.asString(self.textElements)}, imageElements: ${Mapper.asString(self.imageElements)})';
  @override int hash(Note self) => Mapper.hash(self.id) ^ Mapper.hash(self.name) ^ Mapper.hash(self.parentId) ^ Mapper.hash(self.creationTime) ^ Mapper.hash(self.lastEditTime) ^ Mapper.hash(self.paintElements) ^ Mapper.hash(self.textElements) ^ Mapper.hash(self.imageElements);
  @override bool equals(Note self, Note other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.name, other.name) && Mapper.isEqual(self.parentId, other.parentId) && Mapper.isEqual(self.creationTime, other.creationTime) && Mapper.isEqual(self.lastEditTime, other.lastEditTime) && Mapper.isEqual(self.paintElements, other.paintElements) && Mapper.isEqual(self.textElements, other.textElements) && Mapper.isEqual(self.imageElements, other.imageElements);

  @override Function get typeFactory => (f) => f<Note>();
}

extension NoteMapperExtension  on Note {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  NoteCopyWith<Note> get copyWith => NoteCopyWith(this, $identity);
}

abstract class NoteCopyWith<$R> {
  factory NoteCopyWith(Note value, Then<Note, $R> then) = _NoteCopyWithImpl<$R>;
  ListCopyWith<$R, PaintElement, PaintElementCopyWith<$R>> get paintElements;
  ListCopyWith<$R, TextElement, TextElementCopyWith<$R>> get textElements;
  MapCopyWith<$R, String, ImageElement, ImageElementCopyWith<$R>> get imageElements;
  $R call({String? id, String? name, String? parentId, DateTime? creationTime, DateTime? lastEditTime, List<PaintElement>? paintElements, List<TextElement>? textElements, Map<String, ImageElement>? imageElements});
  $R apply(Note Function(Note) transform);
}

class _NoteCopyWithImpl<$R> extends BaseCopyWith<Note, $R> implements NoteCopyWith<$R> {
  _NoteCopyWithImpl(Note value, Then<Note, $R> then) : super(value, then);

  @override ListCopyWith<$R, PaintElement, PaintElementCopyWith<$R>> get paintElements => ListCopyWith($value.paintElements, (v, t) => PaintElementCopyWith(v, t), (v) => call(paintElements: v));
  @override ListCopyWith<$R, TextElement, TextElementCopyWith<$R>> get textElements => ListCopyWith($value.textElements, (v, t) => TextElementCopyWith(v, t), (v) => call(textElements: v));
  @override MapCopyWith<$R, String, ImageElement, ImageElementCopyWith<$R>> get imageElements => MapCopyWith($value.imageElements, (v, t) => ImageElementCopyWith(v, t), (v) => call(imageElements: v));
  @override $R call({String? id, String? name, Object? parentId = $none, DateTime? creationTime, DateTime? lastEditTime, List<PaintElement>? paintElements, List<TextElement>? textElements, Map<String, ImageElement>? imageElements}) => $then(Note(id: id ?? $value.id, name: name ?? $value.name, parentId: or(parentId, $value.parentId), creationTime: creationTime ?? $value.creationTime, lastEditTime: lastEditTime ?? $value.lastEditTime, paintElements: paintElements ?? $value.paintElements, textElements: textElements ?? $value.textElements, imageElements: imageElements ?? $value.imageElements));
}

class PaintElementMapper extends BaseMapper<PaintElement> {
  PaintElementMapper._();

  @override Function get decoder => decode;
  PaintElement decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  PaintElement fromMap(Map<String, dynamic> map) => PaintElement(points: Mapper.i.$get(map, 'p'), color: Mapper.i.$get(map, 'c'), penType: Mapper.i.$get(map, 'l'), thickness: Mapper.i.$get(map, 't'), pageNum: Mapper.i.$get(map, 'n'));

  @override Function get encoder => (PaintElement v) => encode(v);
  dynamic encode(PaintElement v) => toMap(v);
  Map<String, dynamic> toMap(PaintElement p) => {'p': Mapper.i.$enc(p.points, 'points'), 'c': Mapper.i.$enc(p.color, 'color'), 'l': Mapper.i.$enc(p.penType, 'penType'), 't': Mapper.i.$enc(p.thickness, 'thickness'), 'n': Mapper.i.$enc(p.pageNum, 'pageNum')};

  @override String stringify(PaintElement self) => 'PaintElement(points: ${Mapper.asString(self.points)}, pageNum: ${Mapper.asString(self.pageNum)}, thickness: ${Mapper.asString(self.thickness)}, color: ${Mapper.asString(self.color)}, penType: ${Mapper.asString(self.penType)})';
  @override int hash(PaintElement self) => Mapper.hash(self.points) ^ Mapper.hash(self.pageNum) ^ Mapper.hash(self.thickness) ^ Mapper.hash(self.color) ^ Mapper.hash(self.penType);
  @override bool equals(PaintElement self, PaintElement other) => Mapper.isEqual(self.points, other.points) && Mapper.isEqual(self.pageNum, other.pageNum) && Mapper.isEqual(self.thickness, other.thickness) && Mapper.isEqual(self.color, other.color) && Mapper.isEqual(self.penType, other.penType);

  @override Function get typeFactory => (f) => f<PaintElement>();
}

extension PaintElementMapperExtension  on PaintElement {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  PaintElementCopyWith<PaintElement> get copyWith => PaintElementCopyWith(this, $identity);
}

abstract class PaintElementCopyWith<$R> {
  factory PaintElementCopyWith(PaintElement value, Then<PaintElement, $R> then) = _PaintElementCopyWithImpl<$R>;
  $R call({List<Point<num>>? points, Color? color, PenType? penType, num? thickness, int? pageNum});
  $R apply(PaintElement Function(PaintElement) transform);
}

class _PaintElementCopyWithImpl<$R> extends BaseCopyWith<PaintElement, $R> implements PaintElementCopyWith<$R> {
  _PaintElementCopyWithImpl(PaintElement value, Then<PaintElement, $R> then) : super(value, then);

  @override $R call({List<Point<num>>? points, Color? color, PenType? penType, num? thickness, int? pageNum}) => $then(PaintElement(points: points ?? $value.points, color: color ?? $value.color, penType: penType ?? $value.penType, thickness: thickness ?? $value.thickness, pageNum: pageNum ?? $value.pageNum));
}

class TextElementMapper extends BaseMapper<TextElement> {
  TextElementMapper._();

  @override Function get decoder => decode;
  TextElement decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  TextElement fromMap(Map<String, dynamic> map) => TextElement(text: Mapper.i.$get(map, 't'), bold: Mapper.i.$get(map, 'b'), italic: Mapper.i.$get(map, 'i'), superscript: Mapper.i.$get(map, 'u'), subscript: Mapper.i.$get(map, 'd'), fontSize: Mapper.i.$get(map, 's'), fontColor: Mapper.i.$getOpt(map, 'c'));

  @override Function get encoder => (TextElement v) => encode(v);
  dynamic encode(TextElement v) => toMap(v);
  Map<String, dynamic> toMap(TextElement t) => {'t': Mapper.i.$enc(t.text, 'text'), 'b': Mapper.i.$enc(t.bold, 'bold'), 'i': Mapper.i.$enc(t.italic, 'italic'), 'u': Mapper.i.$enc(t.superscript, 'superscript'), 'd': Mapper.i.$enc(t.subscript, 'subscript'), 's': Mapper.i.$enc(t.fontSize, 'fontSize'), 'c': Mapper.i.$enc(t.fontColor, 'fontColor')};

  @override String stringify(TextElement self) => 'TextElement(text: ${Mapper.asString(self.text)}, bold: ${Mapper.asString(self.bold)}, italic: ${Mapper.asString(self.italic)}, superscript: ${Mapper.asString(self.superscript)}, subscript: ${Mapper.asString(self.subscript)}, fontSize: ${Mapper.asString(self.fontSize)}, fontColor: ${Mapper.asString(self.fontColor)})';
  @override int hash(TextElement self) => Mapper.hash(self.text) ^ Mapper.hash(self.bold) ^ Mapper.hash(self.italic) ^ Mapper.hash(self.superscript) ^ Mapper.hash(self.subscript) ^ Mapper.hash(self.fontSize) ^ Mapper.hash(self.fontColor);
  @override bool equals(TextElement self, TextElement other) => Mapper.isEqual(self.text, other.text) && Mapper.isEqual(self.bold, other.bold) && Mapper.isEqual(self.italic, other.italic) && Mapper.isEqual(self.superscript, other.superscript) && Mapper.isEqual(self.subscript, other.subscript) && Mapper.isEqual(self.fontSize, other.fontSize) && Mapper.isEqual(self.fontColor, other.fontColor);

  @override Function get typeFactory => (f) => f<TextElement>();
}

extension TextElementMapperExtension  on TextElement {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  TextElementCopyWith<TextElement> get copyWith => TextElementCopyWith(this, $identity);
}

abstract class TextElementCopyWith<$R> {
  factory TextElementCopyWith(TextElement value, Then<TextElement, $R> then) = _TextElementCopyWithImpl<$R>;
  $R call({String? text, bool? bold, bool? italic, bool? superscript, bool? subscript, int? fontSize, Color? fontColor});
  $R apply(TextElement Function(TextElement) transform);
}

class _TextElementCopyWithImpl<$R> extends BaseCopyWith<TextElement, $R> implements TextElementCopyWith<$R> {
  _TextElementCopyWithImpl(TextElement value, Then<TextElement, $R> then) : super(value, then);

  @override $R call({String? text, bool? bold, bool? italic, bool? superscript, bool? subscript, int? fontSize, Object? fontColor = $none}) => $then(TextElement(text: text ?? $value.text, bold: bold ?? $value.bold, italic: italic ?? $value.italic, superscript: superscript ?? $value.superscript, subscript: subscript ?? $value.subscript, fontSize: fontSize ?? $value.fontSize, fontColor: or(fontColor, $value.fontColor)));
}

class ImageElementMapper extends BaseMapper<ImageElement> {
  ImageElementMapper._();

  @override Function get decoder => decode;
  ImageElement decode(dynamic v) => checked(v, (Map<String, dynamic> map) => fromMap(map));
  ImageElement fromMap(Map<String, dynamic> map) => ImageElement(id: Mapper.i.$get(map, 'i'), imageData: Mapper.i.$get(map, 'd'), relX: Mapper.i.$get(map, 'x'), relY: Mapper.i.$get(map, 'y'), pageNum: Mapper.i.$get(map, 'n'), width: Mapper.i.$get(map, 'w'), height: Mapper.i.$get(map, 'h'));

  @override Function get encoder => (ImageElement v) => encode(v);
  dynamic encode(ImageElement v) => toMap(v);
  Map<String, dynamic> toMap(ImageElement i) => {'i': Mapper.i.$enc(i.id, 'id'), 'd': Mapper.i.$enc(i.imageData, 'imageData'), 'x': Mapper.i.$enc(i.relX, 'relX'), 'y': Mapper.i.$enc(i.relY, 'relY'), 'n': Mapper.i.$enc(i.pageNum, 'pageNum'), 'w': Mapper.i.$enc(i.width, 'width'), 'h': Mapper.i.$enc(i.height, 'height')};

  @override String stringify(ImageElement self) => 'ImageElement(id: ${Mapper.asString(self.id)}, imageData: ${Mapper.asString(self.imageData)}, relX: ${Mapper.asString(self.relX)}, relY: ${Mapper.asString(self.relY)}, pageNum: ${Mapper.asString(self.pageNum)}, width: ${Mapper.asString(self.width)}, height: ${Mapper.asString(self.height)})';
  @override int hash(ImageElement self) => Mapper.hash(self.id) ^ Mapper.hash(self.imageData) ^ Mapper.hash(self.relX) ^ Mapper.hash(self.relY) ^ Mapper.hash(self.pageNum) ^ Mapper.hash(self.width) ^ Mapper.hash(self.height);
  @override bool equals(ImageElement self, ImageElement other) => Mapper.isEqual(self.id, other.id) && Mapper.isEqual(self.imageData, other.imageData) && Mapper.isEqual(self.relX, other.relX) && Mapper.isEqual(self.relY, other.relY) && Mapper.isEqual(self.pageNum, other.pageNum) && Mapper.isEqual(self.width, other.width) && Mapper.isEqual(self.height, other.height);

  @override Function get typeFactory => (f) => f<ImageElement>();
}

extension ImageElementMapperExtension  on ImageElement {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);
  ImageElementCopyWith<ImageElement> get copyWith => ImageElementCopyWith(this, $identity);
}

abstract class ImageElementCopyWith<$R> {
  factory ImageElementCopyWith(ImageElement value, Then<ImageElement, $R> then) = _ImageElementCopyWithImpl<$R>;
  $R call({String? id, Uint8List? imageData, num? relX, num? relY, int? pageNum, num? width, num? height});
  $R apply(ImageElement Function(ImageElement) transform);
}

class _ImageElementCopyWithImpl<$R> extends BaseCopyWith<ImageElement, $R> implements ImageElementCopyWith<$R> {
  _ImageElementCopyWithImpl(ImageElement value, Then<ImageElement, $R> then) : super(value, then);

  @override $R call({String? id, Uint8List? imageData, num? relX, num? relY, int? pageNum, num? width, num? height}) => $then(ImageElement(id: id ?? $value.id, imageData: imageData ?? $value.imageData, relX: relX ?? $value.relX, relY: relY ?? $value.relY, pageNum: pageNum ?? $value.pageNum, width: width ?? $value.width, height: height ?? $value.height));
}


// === GENERATED ENUM MAPPERS AND EXTENSIONS ===

class PenTypeMapper extends EnumMapper<PenType> {
  PenTypeMapper._();

  @override  PenType decode(dynamic value) {
    switch (value) {
      case 'pen': return PenType.pen;
      case 'graphitPen': return PenType.graphitPen;
      default: throw MapperException.unknownEnumValue(value);
    }
  }

  @override  dynamic encode(PenType self) {
    switch (self) {
      case PenType.pen: return 'pen';
      case PenType.graphitPen: return 'graphitPen';
    }
  }
}

extension PenTypeMapperExtension on PenType {
  dynamic toValue() => Mapper.toValue(this);
  @Deprecated('Use \'toValue\' instead')
  String toStringValue() => Mapper.toValue(this) as String;
}


// === GENERATED UTILITY CODE ===

class Mapper {
  Mapper._();

  static MapperContainer i = MapperContainer(_mappers);

  static T fromValue<T>(dynamic value) => i.fromValue<T>(value);
  static T fromMap<T>(Map<String, dynamic> map) => i.fromMap<T>(map);
  static T fromIterable<T>(Iterable<dynamic> iterable) => i.fromIterable<T>(iterable);
  static T fromJson<T>(String json) => i.fromJson<T>(json);

  static dynamic toValue(dynamic value) => i.toValue(value);
  static Map<String, dynamic> toMap(dynamic object) => i.toMap(object);
  static Iterable<dynamic> toIterable(dynamic object) => i.toIterable(object);
  static String toJson(dynamic object) => i.toJson(object);

  static bool isEqual(dynamic value, Object? other) => i.isEqual(value, other);
  static int hash(dynamic value) => i.hash(value);
  static String asString(dynamic value) => i.asString(value);

  static void use<T>(BaseMapper<T> mapper) => i.use<T>(mapper);
  static BaseMapper<T>? unuse<T>() => i.unuse<T>();
  static void useAll(List<BaseMapper> mappers) => i.useAll(mappers);

  static BaseMapper<T>? get<T>([Type? type]) => i.get<T>(type);
  static List<BaseMapper> getAll() => i.getAll();
}

mixin Mappable implements MappableMixin {
  String toJson() => Mapper.toJson(this);
  Map<String, dynamic> toMap() => Mapper.toMap(this);

  @override
  String toString() {
    return _guard(() => Mapper.asString(this), super.toString);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            _guard(() => Mapper.isEqual(this, other), () => super == other));
  }

  @override
  int get hashCode {
    return _guard(() => Mapper.hash(this), () => super.hashCode);
  }

  T _guard<T>(T Function() fn, T Function() fallback) {
    try {
      return fn();
    } on MapperException catch (e) {
      if (e.isUnsupportedOrUnallowed()) {
        return fallback();
      } else {
        rethrow;
      }
    }
  }
}
