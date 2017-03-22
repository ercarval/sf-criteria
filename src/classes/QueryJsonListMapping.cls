/**
 *
 * @author: Eduardo - @ercarval
 */
public with sharing class QueryJsonListMapping extends QueryMapping {

    public QueryJsonListMapping(String field){
    	super(field);
    }

	private List<String> values;

	public List<String> getValues() {
		if (value == null)	return null;
		return (List<String>) JSON.deserialize(value, List<String>.class );
	}

	public void setValues (List<String> values) {
		this.values = values;
	}

}