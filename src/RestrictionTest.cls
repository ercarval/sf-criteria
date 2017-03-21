@isTest
private class RestrictionTest {

    @isTest
    static void itShouldBuildWhereConstrants() {

        DateTime now = DateTime.now();
        DateTime yesterday = now - 1;


        String expextedDateTime = now.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        String expextedYesterdayDateTime = yesterday.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');


        System.assertEquals( 'Name = \'Value\'' , Restriction.eq ('Name', 'Value') );
        System.assertEquals( 'Name = true' , Restriction.eq ('Name', true) );
        System.assertEquals( 'Name = 10.0' , Restriction.eq ('Name', 10.0D) );
        System.assertEquals( 'Name = 10' , Restriction.eq ('Name', 10) );
        System.assertEquals( 'name = \'Value\'' , Restriction.eq ('Name', new QueryMapping ('name', 'Value') ) );
        System.assertEquals( 'name = \'Value\'' , Restriction.eq ( new QueryMapping ('name', 'Value') ) );

        System.assertEquals( 'name = true' , Restriction.booleanEq ( new QueryMapping ('name', 'true') ) );

        System.assertEquals( 'name != \'Value\'' , Restriction.notEq ( new QueryMapping ('name', 'Value') ) );
        System.assertEquals( 'Name != \'Value\'' , Restriction.notEq ('Name', 'Value') );
        System.assertEquals( 'Name != 10' , Restriction.notEq ('Name', 10) );

        System.assertEquals( 'name < \'10\'' , Restriction.lt ( new QueryMapping ('name', '10') ) );
        System.assertEquals( 'Name < \'10\'' , Restriction.lt ('Name', '10') );

        System.assertEquals( 'name <= \'10\'' , Restriction.le ( new QueryMapping ('name', '10') ) );
        System.assertEquals( 'Name <= \'10\'' , Restriction.le ('Name', '10') );

        System.assertEquals( 'name > \'10\'' , Restriction.gt ( new QueryMapping ('name', '10') ) );
        System.assertEquals( 'Name > \'10\'' , Restriction.gt ('Name', '10') );

        System.assertEquals( 'name >= \'10\'' , Restriction.ge ( new QueryMapping ('name', '10') ) );
        System.assertEquals( 'Name >= \'10\'' , Restriction.ge ('Name', '10') );

        System.assertEquals( 'createdDate < ' + expextedDateTime , Restriction.lt ('createdDate', now) );
        System.assertEquals( 'createdDate <= ' + expextedDateTime , Restriction.le ('createdDate', now) );
        System.assertEquals( 'createdDate > ' + expextedDateTime , Restriction.gt ('createdDate', now) );
        System.assertEquals( 'createdDate >= ' + expextedDateTime , Restriction.ge ('createdDate', now) );

        System.assertEquals( 'createdDate >= ' + expextedDateTime + ' and createdDate <= ' + expextedYesterdayDateTime
                             , Restriction.between('createdDate' , now,  yesterday ) );

        System.assertEquals( 'price >= \'9\' and price <= \'10\'' , Restriction.between('price' , '9',  '10') );

        System.assertEquals( 'name = \'Value\'' , Restriction.eqOrLike ( new QueryMapping ('name', 'Value') ) );
        System.assertEquals( 'name like \'Value%\'' , Restriction.eqOrLike ( new QueryMapping ('name', 'Value*') ) );
        System.assertEquals( 'name like \'Value%\'' , Restriction.isLike ( 'name' , new QueryMapping ('name', 'Value%') ) );

        System.debug( 'Not Null ----  |' + Restriction.isNotNull (  'name', 'null' ) + '|'  );

        System.assertEquals( 'name != null ' , Restriction.isNotNull (  'name', 'null' ) );
        System.assertEquals( 'name != null ' , Restriction.isNotNull ( 'name' ) );

        System.assertEquals( 'name = null ' , Restriction.isNull (  'name', 'null' ) );
        System.assertEquals( 'name = null ' , Restriction.isNull ( 'name' ) );

        System.assertEquals( 'name = null ' , Restriction.isNull (  'name', 'null' ) );
        System.assertEquals( 'name = null ' , Restriction.isNull ( new QueryMapping ('name', 'Value')  ) );

        System.assertEquals( 'name in ( \'34234*\',\'Val2\',\'val3\' )' , Restriction.isIn('name' , new String[] {'34234*', 'Val2', 'val3'}) );

        System.assertEquals( 'name not in ( \'34234*\',\'Val2\',\'val3\' )' , Restriction.isNotIn('name' , new String[] {'34234*', 'Val2', 'val3'}) );

        System.assertEquals( 'id in (select conta__c from Account where id = 1)' , Restriction.isInSubQuery (  'id', 'select conta__c from Account where id = 1' ) );

        System.assertEquals( ' order by conta__c' , Restriction.orderBy ('conta__c' ) );
        System.assertEquals( ' limit 1' , Restriction.addLimit ( 1 ) );


        System.assertEquals( 'id in (select conta__c from Account where id = 1)'
                             ,  Restriction.isIn('id',
                                     new Criteria ('select conta__c from Account')
                                     .add( Restriction.eq('id', 1) ) ) );

        System.assertEquals( 'id not in (select conta__c from Account where id = 1)'
                             ,  Restriction.isNotIn('id',
                                     new Criteria ('select conta__c from Account')
                                     .add( Restriction.eq('id', 1) ) ) );


    }


}