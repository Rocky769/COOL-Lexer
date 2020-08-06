class Main{
  main() : Object {
      let i : Int <- (new IO).in_int() in {  -- input number
            if(arm(i)=true)
              then (new IO).out_string("It is an armstrong number")  -- if input is an armstrong number
            else
              (new IO).out_string("It is not an armstrong number")   -- if not an armstrong number
            fi;
            (new IO).out_string("\n");  -- prints new line
      }
  };

  arm ( num : Int ) : Bool {    -- returns true or false to the statement that num is an armstrong number

    let rem:Int<-0, result:Int<-0, i:Int<-num in {
      while ( not (i= 0) ) loop {
          rem <- modulo(i,10);
          result <- result + (rem * rem * rem);  -- sum of cube of digits of input number
          i <- i/10;
      }
      pool; -- --------------> EOF in comment case
      if (result=num)  (* checks if sum of cube of digits = input number
        then true
      else
        false
      fi;
    }
  };

  modulo( n:Int, k:Int ) : Int {  -- same as % in C
        if (k<=n)
          then modulo(n-k,k)
        else
          n
        fi
  };

};
