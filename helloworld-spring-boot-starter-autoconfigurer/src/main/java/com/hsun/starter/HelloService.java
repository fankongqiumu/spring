package com.hsun.starter;

public class HelloService {

    HelloProerties helloProerties;

    public HelloProerties getHelloProerties() {
        return helloProerties;
    }

    public void setHelloProerties(HelloProerties helloProerties) {
        this.helloProerties = helloProerties;
    }

    public  String sayHello(String name){
        return helloProerties.getPrefix()+"-"+name +helloProerties.getSuffix();
    }
}
