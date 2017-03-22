/**
 *
 * @author: Eduardo - @ercarval
 */
public with sharing class Restriction {

    static final String SINGLE_QUOTES       =   '\'' ;
    static final String EQUALS              =   ' = ' ;
    static final String ANDZ                =   ' and ' ;
    static final String ORZ                 =   ' or ' ;
    static final String LIKEZ               =   ' like ' ;
    static final String NOT_NULL            =   ' != null ' ;
    static final String IS_NULL             =   ' = null ' ;
    static final String IS_IN               =   ' in ' ;
    static final String IS_NOT_IN           =   ' not in ' ;
    static final String NOT_EQUALS          =   ' != ' ;
    static final String GREATER_THAN        =   ' > ' ;
    static final String GREATER_THAN_EQUALS =   ' >= ' ;
    static final String LESS_THAN           =   ' < ' ;
    static final String LESS_THAN_EQUALS    =   ' <= ' ;
    static final String LIMIT_RESTRICTION   =   ' limit ' ;
    static final String ORDER_BY            =   ' order by ' ;


    public static String logicalOperator (String operator, String constrant) {
        if ( nullToEmpty(constrant) == '') return '';
        return  operator + constrant;
    }

    public static String constrantWithOutSingleQuotes (String fieldName
            , String value
            , String operator) {
        if (nullToEmpty(value) == '') return '';
        return fieldName + operator + value;
    }

    public static String constrant (String fieldName, String operator) {
        return fieldName + operator;
    }

    public static String constrant (String fieldName, String value, String operator) {

        value = nullToEmpty(value);
        if (value == '') return '';

        return fieldName + operator + SINGLE_QUOTES + String.escapeSingleQuotes( value ) + SINGLE_QUOTES;
    }

    public static String constrant (String fieldName, Integer value, String operator) {

        return fieldName + operator +   value ;
    }

    public static String constrant (String fieldName, Boolean value, String operator) {
        return fieldName + operator + value;
    }

    public static String eq (String fieldName, String value) {
        return constrant(fieldName, value , EQUALS);
    }

    public static String eq (String fieldName, Boolean value) {
        return constrant(fieldName, value , EQUALS);
    }

    public static String eq (String fieldName, Integer value) {
        return constrant(fieldName, value , EQUALS);
    }

    public static String eq (String fieldName, Double value) {
        return constrantWithoutSingleQuotes(fieldName, String.valueOf(value) , EQUALS);
    }

    public static String eq (String fieldName, QueryMapping mapping) {
        return constrant(mapping.fieldName, (String) mapping.getValue() , EQUALS);
    }

    public static String eq (QueryMapping mapping) {
        return constrant(mapping.fieldName, (String) mapping.getValue() , EQUALS);
    }

    public static String booleanEq (QueryMapping mapping) {
        return constrant(mapping.fieldName, mapping.getValueAsBoolean() , EQUALS);
    }

    public static String notEq (String fieldName, String value) {
        return constrant(fieldName, value , NOT_EQUALS);
    }

    public static String notEq (String fieldName, Integer value) {
        return constrant(fieldName, value , NOT_EQUALS);
    }

    public static String notEq (QueryMapping mapping) {
        return constrant(mapping.fieldName, (String) mapping.getValue() , NOT_EQUALS);
    }


    public static String lt (String fieldName, String value) {
        return constrant(fieldName, value , LESS_THAN);
    }

    public static String lt (QueryMapping mapping) {
        return constrant(mapping.fieldName, (String) mapping.getValue() , LESS_THAN);
    }

    public static String lt (String fieldName, DateTime value) {
        String dateTimeValue = (value != null ? value.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '');
        return  constrantWithOutSingleQuotes(fieldName, dateTimeValue , LESS_THAN);
    }

    public static String le (String fieldName, String value) {
        return  constrant(fieldName, value , LESS_THAN_EQUALS);
    }

    /**
     * @deprecated
     */
    public static String le (String fieldName, QueryMapping value) {
        return le(value);
    }

    public static String le (QueryMapping mapping) {
        return le (mapping.fieldName, (String) mapping.getValue());
    }

    public static String le (String fieldName, DateTime value) {
        String dateTimeValue = (value != null ? value.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '');
        return  lessThanEqualsDateLiteral(fieldName, dateTimeValue );
    }

    public static String lessThanEqualsDateLiteral (String fieldName, String value) {
        return  constrantWithOutSingleQuotes(fieldName, value , LESS_THAN_EQUALS);
    }

    public static String gt (String fieldName, String value) {
        return  constrant(fieldName, value , GREATER_THAN);
    }

    public static String gt (QueryMapping mapping) {
        return  constrant(mapping.fieldName, mapping.getValue(), GREATER_THAN);
    }

    public static String gt (String fieldName, DateTime value) {
        String dateTimeValue = (value != null ? value.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '');
        return  constrantWithOutSingleQuotes(fieldName, dateTimeValue , GREATER_THAN);
    }

    public static String ge (String fieldName, String value) {
        return  constrant(fieldName, value , GREATER_THAN_EQUALS);
    }

    public static String greaterThanEqualsDateLiteral (String fieldName, String value) {
        return  constrantWithOutSingleQuotes(fieldName, value , GREATER_THAN_EQUALS);
    }


    public static String ge (String fieldName, QueryMapping mapping) {
        return  constrant(fieldName, mapping.getValue() , GREATER_THAN_EQUALS);
    }

    public static String ge (QueryMapping mapping) {
        return  constrant(mapping.fieldName, mapping.getValue() , GREATER_THAN_EQUALS);
    }

    public static String ge (String fieldName, DateTime value) {
        String dateTimeValue = (value != null ? value.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '');
        return  greaterThanEqualsDateLiteral(fieldName, dateTimeValue );
    }

    public static String between ( String fieldName ,  DateTime lo, DateTime hi  ) {
        String lowFormatedDate =  ( lo != null ) ? lo.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '';
        String hightFormatedDate = ( hi != null ) ? hi.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') : '';
        return  betweenDates(fieldName, lowFormatedDate, hightFormatedDate);
    }

    public static String betweenDates (String fieldName, String lo , String hi  ) {

        if ( (lo == null || lo == '') && (hi == null || hi == '') ) return '';

        if (lo == null || lo == '')
            return constrantWithOutSingleQuotes ( fieldName, hi ,   EQUALS);

        if (hi == null || hi == '')
            return constrantWithOutSingleQuotes ( fieldName, lo ,   EQUALS);

        return    constrantWithOutSingleQuotes (fieldName, lo , GREATER_THAN_EQUALS)
                  + andd ( constrantWithOutSingleQuotes (fieldName, hi , LESS_THAN_EQUALS) ) ;

    }

    public static String betweenDates (QueryMapping lo  , QueryMapping hi  ) {
        return betweenDates (lo.fieldName , lo.getValue() , hi.getValue());
    }

    public static String between (String fieldName, String lo , String hi ) {
        if ( (lo == null || lo == '') && (hi == null || hi == '') ) return '';
        if (lo == null || lo == '') return eq(fieldName, hi);
        if (hi == null || hi == '') return eq(fieldName, lo);

        return    constrant(fieldName, lo , GREATER_THAN_EQUALS)
                  + andd ( constrant(fieldName, hi , LESS_THAN_EQUALS) ) ;

    }

    public static String isLike (String fieldName, String value) {
        return    constrant(fieldName, value , LIKEZ);
    }

    public static String isLike (String fieldName, QueryMapping value) {
        return    constrant(fieldName, (String) value.getValue() , LIKEZ);
    }

    public static String eqOrLike ( QueryMapping mapping ) {
        return eqOrLike( mapping.fieldName, mapping.getValue() );
    }

    public static String eqOrLike (String fieldName, String value) {
        if (value == null) return '';

        if (value.indexOf('*') > -1) {
            return isLike(fieldName, value.replace ('*', '%'));
        }

        return eq (fieldName, value);
    }

    //@deprecated
    public static String isNotNull (String fieldName, String value) {
        return    constrant(fieldName, NOT_NULL);
    }

    public static String isNotNull (String fieldName) {
        return    constrant(fieldName, NOT_NULL);
    }

    /**
     * @deprecated
     */
    public static String isNull (String fieldName, String value) {
        return isNull(fieldName);
    }

    public static String isNull (String fieldName) {
        return constrant(fieldName, IS_NULL);
    }

    public static String isNull (QueryMapping mapping ) {
        return isNull( mapping.fieldName );
    }


    public static String isIn ( String fieldName ,  Criteria criteria) {
        String value = ( criteria.toSoqlString() != criteria.query ) ? '(' + criteria.toSoqlString() + ')'  : '' ;
        return constrantWithOutSingleQuotes (fieldName, value , IS_IN )  ;
    }

    public static String isNotIn ( String fieldName ,  Criteria criteria) {
        String value = ( criteria.toSoqlString() != criteria.query ) ? '(' + criteria.toSoqlString() + ')'  : '' ;
        return constrantWithOutSingleQuotes (fieldName, value , IS_NOT_IN )  ;
    }


    public static String isIn (QueryMapping mapping) {
        return    constrantWithOutSingleQuotes(mapping.fieldName
                                               , mapping.getValue()
                                               , IS_IN );
    }

    public static String isIn (QueryListMapping mapping) {
        return    isIn ( mapping.fieldName , mapping.getValues() );
    }

    public static String isIn (QueryJsonListMapping mapping) {
        return    isIn ( mapping.fieldName , mapping.getValues() );
    }

    public static String isIn (String fieldName, String[] values) {
        return    isIn (fieldName , convertArrayStringIntoInClause(values) );
    }

    public static String isIn (String fieldName, String values) {
        return    constrantWithOutSingleQuotes(fieldName, values , IS_IN );
    }

    public static String isInSubQuery (String fieldName, String subquery) {
        String value = subquery != null ? '(' + subquery + ')' : subquery;
        return    constrantWithOutSingleQuotes(fieldName, value , IS_IN );
    }

    public static String isNotIn (QueryMapping mapping) {
        return    isNotIn(mapping.fieldName , mapping.getValue());
    }

    public static String isNotIn (String fieldName, String[] values) {
        return    isNotIn (fieldName , convertArrayStringIntoInClause(values) );
    }

    public static String isNotIn (String fieldName, String values) {
        return    constrantWithOutSingleQuotes(fieldName, values , IS_NOT_IN );
    }

    public static String convertArrayStringIntoInClause (String[] values) {

        if (isNullOrEmpty(values)) {
            return null;
        }

        String value = '( ';
        Integer i = 0;
        for (String val : values) {
            if (i > 0) value += ',';
            value += addStringInQuery(val);
            i++;
        }
        value += ' )';
        return value;
    }

    public static String andd ( String constrant ) {
        return logicalOperator(ANDZ, constrant);
    }

    public static String orr ( String constrant ) {
        return logicalOperator(ORZ, constrant);
    }

    public static String addLimit (Integer queryLimit) {
        return LIMIT_RESTRICTION + queryLimit;
    }

    public static String orderBy ( String expression ) {
        return ORDER_BY + expression;
    }

    private static String addStringInQuery (String value) {
        return SINGLE_QUOTES + String.escapeSingleQuotes(value) + SINGLE_QUOTES;
    }


    private static String nullToEmpty (String value) {
        return (value != null) ? value.trim() : '';
    }

    public static Junction disjunction() {
        return new Disjunction();
    }

    public static Junction conjunction() {
        return new Conjunction();
    }

    public static boolean isNullOrEmpty(List<Object> targetList) {
        return  targetList == null || targetList.isEmpty();
    }

}