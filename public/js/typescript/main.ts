class HelloTyper {

    a:string
    b:number

    constructor(x:string,y:number){
        this.a = x;
        this.b = y;
    }

    hello() : void{
        console.log(this.a);
    }

//    // get accessor
//    get getAccessorName() : returnType{
//        console.log(this.a)
//    }
//
//    // set accessor
//    set setAccessorName(arg : argType){
//        console.log(this.b);
//    }
//
//    // static member variable
//    static varName : varType = expression;
//
//    // static member function
//    static funcName(arg1 : arg1Type, arg2 : arg2Type) : returnType {
//
//    }

}

var typer:HelloTyper = new HelloTyper("Hello TypeScript!", 99);

typer.hello()