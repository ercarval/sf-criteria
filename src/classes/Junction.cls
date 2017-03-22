/**
 * Used to provide Criteria Fluent Interface
 * @author: Eduardo - @ercarval
 * @see Critria class
 */
global with sharing abstract class Junction {

	private List<String> criterias = new List<String>();
	private String operator;

	public Junction(String operator) {
		this.operator = operator;
	}

	public Junction add(String expression) {
		if (expression == '') {
			return this;
		}

		criterias.add(expression);
		return this;
	}

	public Junction add(Junction junction) {
		criterias.add(junction.toString());
		return this;
	}

	private void setOperator(String operator) {
		this.operator = operator;
	}

	override
	global String toString() {
		String result = '(';

		for (integer i = 0; i < criterias.size(); i++) {

			result += criterias.get(i);
			if (i != criterias.size() - 1) {
				result += ' ' + this.operator + ' ';
			}
		}
		result += ')';
		return result;
	}
}