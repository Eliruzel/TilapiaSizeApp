import 'dart:js_interop';

@JS('window.location.hash')
external JSString get _hash;
@JS('window.history.replaceState')
external void _replaceState(JSAny? data, JSString title, JSString url);

String get sectionFragment =>
    Uri.decodeComponent(_hash.toDart.replaceFirst('#', ''));
void setSectionFragment(String id) =>
    _replaceState(null, ''.toJS, '#${Uri.encodeComponent(id)}'.toJS);
