cases =
    * ls: 'f = (a :: number, b :: number) -> (a + b :: number)'
      js: 'var f: (arg0: number, arg1: number) => number;f = function(a, b){return a + b;};'
    * ls: 'f = (a :: number, b :: number) -> :: number; a + b'
      js: 'var f: (arg0: number, arg1: number) => number;f = function(a, b){return a + b;};'
    * ls: 'f = (a, b) -> a + b :: (number, number) -> number'
      js: 'var f: (arg0: number, arg1: number) => number;f = function(a, b){return a + b;};'
    * ls: '''
          f = (a :: number, b :: number) -> :: number
              a + b
          '''
      js: 'var f: (arg0: number, arg1: number) => number;f = function(a, b){return a + b;};'
    * ls: '''
          f = (a :: number, b :: number) ->
              :: number
              a + b
          '''
      js: 'var f: (arg0: number, arg1: number) => number;f = function(a, b){return a + b;};'
    * ls: 'objs.map(({ a, b }) -> (x) -> a * x + b :: ({ a: number, b: number }) -> (number) -> number)'
      js: 'objs.map(function(arg$: {a: number,b: number}): (arg0: number) => number{var a, b;a = arg$.a, b = arg$.b;return function(x){return a * x + b;};});'
    * ls: 'map = (as, f) -> as.map(f) :: forall A, B, (Array(A), (A) -> B) -> Array B'
      js: 'var map: <A, B>(arg0: Array<A>, arg1: (arg0: A) => B) => Array<B>;map = function(as, f){return as.map(f);};'
    * ls: 'apply-map (as, f) -> as.map(f) :: forall A, B, (Array(A), (A) -> B) -> Array B'
      js: 'applyMap(function<A, B>(as: Array<A>, f: (arg0: A) => B): Array<B>{return as.map(f);});'


for { ls, js } in cases
    actual = LiveScript.compile ls, { +bare, -header }
    eq js, actual.replace /\n\s*/g, ''
