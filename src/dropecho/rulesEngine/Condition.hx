package dropecho.rulesEngine;

@:expose
class Condition {
	var _fact:String = "";
	var _op:Operator = Operator.EQ;
	var _value:Dynamic = null;

	public function new(fact:String, op:Operator, value:Dynamic) {
		this._fact = fact;
		this._op = op;
		this._value = value;
	}

	public function matches(bb:Blackboard):Bool {
		var val:Dynamic = bb.get(_fact);

		switch (_op) {
			case GT:
				return val > _value;
			case GTE:
				return val >= _value;
			case LT:
				return val < _value;
			case LTE:
				return val <= _value;
			case EQ:
				#if js
				return js.Syntax.strictEq(val, _value);
				#else
				return val == _value;
				#end
			case NEQ:
				#if js
				return js.Syntax.strictNeq(val, _value);
				#else
				return val != _value;
				#end
			default:
				return false;
		}
	}

	public function reason():String {
		return _fact + " should be " + _op + " " + _value;
	}

	public function result(bb:Blackboard):ConditionResult {
		return new ConditionResult(this, matches(bb));
	}
}
