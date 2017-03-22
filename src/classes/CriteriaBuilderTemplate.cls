/**
 * Provide base template method for criteria builder
 * @author Eduardo R Carvalho
 */
public abstract with sharing class CriteriaBuilderTemplate {


    public Map<String, QueryMapping> fieldsRepository ;
    public Map<String, QueryListMapping> fieldsListRepository ;

    public Criteria criteria;

    public CriteriaBuilderTemplate () {
    	fieldsRepository = new Map<String, QueryMapping>();
    	fieldsListRepository = new Map<String, QueryListMapping> ();
        loadFields();
    }

    public CriteriaBuilderTemplate (Map<String, String> request) {
        this();
        fillCriteriaWithRequest(request);
    }


    abstract
    public void loadFields();

    abstract
    public List<SObject> search ();


    virtual
    public CriteriaBuilderTemplate fillCriteriaWithRequest (Map<String, String> request) {

        for (String field : request.keySet() ) {

            if (fieldsRepository.containsKey(field)) {
                fieldsRepository.get( field ).value = request.get(field);
            }
        }

        return this;
    }


    public QueryMapping get (String field) {
        return fieldsRepository.get (field);
    }


    public QueryListMapping getList (String field) {
        return fieldsListRepository.get (field);
    }


	public CriteriaBuilderTemplate usingField ( String key , String value ) {
		if (value == null) return this;

		QueryMapping field = get(key);
		field.value = value;
		return this;
	}

	public CriteriaBuilderTemplate usingField ( String key , List<String> values ) {
		if (values == null) return this;
		QueryListMapping field = getList(key);
		field.setValues(values);
		return this;
	}

	public CriteriaBuilderTemplate usingField ( String key , Set<String> values ) {
		if (values == null) return this;
		usingField (key, new List<String>(values));
		return this;
	}

}