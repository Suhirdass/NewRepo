@isTest
private class AnimalLocatorTest {

    @isTest static void AnimalLockerMock1(){
        try{
            Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
            string result = AnimalLocator.getAnimalNameById(1);
            string expectedResult = 'fox';
            System.assertEquals(result, expectedResult);
            
        } catch(exception e){
            System.debug('The following exception has occurred' + e.getMessage());
        }
    }
    
    
}