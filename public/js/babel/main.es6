class HelloBabel {

    constructor(x,y){
        this.a = x;
        this.b = y;
    }

    hello(){
        console.log(this.a);
    }

}

var babel = new HelloBabel("Hello Babel!", 77);

babel.hello();