@isTest
global class AnimalLocatorMock implements HttpCalloutMock{

    global HttpResponse respond(HttpRequest request){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"animals" : ["lion","fox","tiger","bear"]}');
        res.setStatusCode(200);
        return res;
    }
}