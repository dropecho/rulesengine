package dropecho.rulesEngine;

import dropecho.interop.AbstractMap;

@:expose
typedef Blackboard = AbstractMap<String, Dynamic>;
// class Blackboard {
//   var _facts:StringMap<Dynamic>;
//
//   public function new() {
//     _facts = new StringMap<Dynamic>();
//   }
//
//   public function set(key:String, val:Dynamic) {
//     _facts.set(key, val);
//   }
//
//   public function get(key:String):Dynamic {
//     return _facts.get(key);
//   }
// }
