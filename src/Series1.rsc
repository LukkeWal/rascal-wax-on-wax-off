module Series1

import IO;


/*
 * Documentation: https://www.rascal-mpl.org/docs/GettingStarted/
 */

/*
 * Hello world
 *
 * - Import IO, write a function that prints out Hello World!
 * - open the console (click "Import in new Rascal Terminal")
 * - import this module and invoke helloWorld.
 */
 
void helloWorld() {
  println("Helloworld!");
} 


/*
 * FizzBuzz (https://en.wikipedia.org/wiki/Fizz_buzz)
 * - implement imperatively
 * - implement as list-returning function
 */
 
list[str] fizzBuzz(int max) {
  int n = 1;
  list[str] result = [];
  while (n <= max){
    result = result + "";
    if (!(n%5 == 0|| n%3 == 0)){
      result[n-1] = "<n>";
    } else {
      if (n%3 == 0){
      result[n-1] += "Fizz";
      }
      if (n%5 == 0){
        result[n-1] += "Buzz";
      };
    };
    n += 1;
  };
  return result;
}

/*
 * Factorial
 * - first using ordinary recursion
 * - then using pattern-based dispatch 
 *  (complete the definition with a default case)
 */
 


int fact(0) = 1;
int fact(1) = 1;

default int fact(int n) = n * fact(n-1);

int factorial(int n) {
  if (n<=0){
    return 1;
  }
  return n * factorial(n-1);
}


/*
 * Comprehensions
 * - use println to see the result
 */
 
void comprehensions() {

  // construct a list of squares of integer from 0 to 9 (use range [0..10])
  println([ i*i | i <- [1..10]]);
  
  // same, but construct a set
  println({ <i, i*i> | i <- [1..10]});
  
  // same, but construct a map
  println(( i: i*i | i <- [1..10]));

  // construct a list of factorials from 0 to 9
  println([ fact(i) | i <- [1..10]]);
  
  // same, but now only for even numbers  
  println([ fact(i) | i <- [0,2..10]]);
}
 

/*
 * Pattern matching
 * - fill in the blanks with pattern match expressions (using :=)
 */
 

void patternMatching() {
  str hello = "Hello World!";
  
  // print all splits of list
  list[int] aList = [1,2,3,4,5];
  for ([*L1, *L2] := aList) {
    println("<L1> and <L2>");
  }
  
  // print all partitions of a set
  set[int] aSet = {1,2,3,4,5};
  for ({*S1, *S2} := aSet) {
    println("<S1> and <S2>");
  } 
}
 
/*
 * Trees
 * - complete the data type ColoredTree with
 *   constructors for binary red and black branches
 * - use the exampleTree() to test in the console
 */
 
data ColoredTree = leaf(int n);
data ColoredTree = black(ColoredTree a, ColoredTree b);
data ColoredTree = red(ColoredTree a, ColoredTree b);
  

ColoredTree exampleTree() = red(black(leaf(1), red(leaf(2), leaf(3))),black(leaf(4), leaf(5)));  
  
  
// write a recursive function summing the leaves
// (use switch or pattern-based dispatch)

int sumLeaves(leaf(int n)) = n;
int sumLeaves(black(ColoredTree a, ColoredTree b)) = sumLeaves(a) + sumLeaves(b);
int sumLeaves(red(ColoredTree a, ColoredTree b)) = sumLeaves(a) + sumLeaves(b);

// same, but now with visit
int sumLeavesWithVisit(ColoredTree t) {
  int result = 0;
  visit (t){
    case leaf(int n): result += n;
  }
  return result;
}

// same, but now with a for loop and deep match
int sumLeavesWithFor(ColoredTree t) {
  int result = 0;
  for (/leaf(n) := t){
    result += n;
  }
  return result;
}

// same, but now with a reducer and deep match
// Reducer = ( <initial value> | <some expression with `it` | <generators> )
int sumLeavesWithReducer(ColoredTree t) = (0 | it + n | /leaf(n) := t);


// add 1 to all leaves; use visit + =>
ColoredTree inc1(ColoredTree t) {
  t = visit (t){
    case leaf(int n) => leaf(n+1)
  }
  return t;
}

// write a test for inc1, run from console using :test
test bool testInc1(){
  ColoredTree testingTree = exampleTree();
  ColoredTree incTestingTree = inc1(testingTree);
  int numberOfLeaves = 0;
  visit(testingTree){
    case leaf(int n): numberOfLeaves += 1;
  }
  int defaultSum = sumLeavesWithVisit(testingTree);
  int incSum = sumLeavesWithVisit(incTestingTree);
  println("defaultSum = <defaultSum>, incSum = <incSum>, numberOfLeaves = <numberOfLeaves>");
  if (defaultSum + numberOfLeaves == incSum){
    return true;
  }
  return false;
}

// define a property for inc1, i.e. a boolean
// function that checks if one tree is inc1 of the other
// (without using inc1).
// Use switch on the tupling of t1 and t2 (`<t1, t2>`)
// or pattern based dispatch.
// Hint! The tree also needs to have the same shape!
bool isInc1(ColoredTree t1, ColoredTree t2) {
  return false; // <- replace
}
 
// write a randomized test for inc1 using the property
// again, execute using :test
test bool testInc1Randomized(ColoredTree t1) = false;


 

 
  
  
