/**
 * VO para lista
 * @author : Eduardo R Carvalho
 */
public with sharing class QueryListMapping extends QueryMapping {

    public QueryListMapping(String field){
    	super(field);
    }

	private List<String> values;

	public List<String> getValues() {
		return values;
	}

	public void setValues (List<String> values) {
		this.values = values;
	}

}