### Anatomy of a user defined function

```
functioName <- function(ParX = defaultX,ParY = defaultY) {

#some r code

return(some object)

}

functionName # print the body of the function
functionName() # run with defaults
functionName(parX = myMat, parY = "data") # supplying specific components

```

* we can assign defaults to the parameters
  * not necessary but can be useful
  * usually want 2 -3 parameters
* Curly bracket marks the start of the body of the function
  * in this we have lines of code with annotation
  * may call other functions
  * may create functions within function
  * may create local variable
* in order for the function to be useful we must ask it to return an object 
  * can be a list or a vector or matrix and so on
  * bracket must be closed after this
  * it's optional 
    * r will return the last object created
* Stylistic conventions
  * Use a prominent has character fencing at start and finish
  * give a header with a function name, description, inputs, and outputs
    * just for clarity
  * Place at the top of the document
  * names inside a function can be short and generic
    * these are local and temporary
  * Should be short and simple, no more than a screenfull
    * we can break one function into a few smaller functions
    * add them together
  * Provide default functions for all function arguments
  * use random number generator as defaults for rapid testing



### Scoping

* global variables are visible to all parts of the code
  * declared in the main body
* Local variables are visible only within a function
  * declared in function or passed to the function through parameters
  * seen and used within the function
* Functions can also see global variable but discouraged to use them
* global environment cannot see local variables
  * these stay in the function
* This applies for functions within functions
  * internal functions can look into the external but external cannot look into internal