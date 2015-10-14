(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end
 
(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals (strList: string list) =
  List.filter (fn str => Char.isUpper (String.sub (str, 0))) strList

fun longest_string1 (strList: string list) = 
  case strList of
    [] => ""
  | _  => foldl (fn (a,b) => if String.size a >= String.size b
		     then a else b) "" strList

fun longest_string2 (strList: string list) = 
  case strList of
    [] => ""
  | _  => foldl (fn (a,b) => if String.size b >= String.size a
		     then b else a) "" strList


fun longest_string_helper f strList =
  case strList of
   [] => ""
  | _ => foldl (fn (a,b) => if f(String.size a, String.size b) then a else b) "" strList
    
val longest_string3 = longest_string_helper (fn (a,b) => a >= b)
val longest_string4 = longest_string_helper (fn (a,b) => a > b)

val longest_capitalized = longest_string1 o only_capitals

fun longest_capitalized2 strList = (longest_string1 o only_capitals) strList

val rev_string = implode o rev o explode

fun rev_string2 str = (implode o rev o explode) str

fun first_answer f aList  = 
  case aList of 
    [] => raise NoAnswer
  | x::xs' => case f(x) of 
	        SOME v => v 
              | NONE => first_answer f xs'

fun all_answers f aList = 
  let fun traverse (acc, xs) = 
    case xs of 
      [] => SOME acc
    | x::xs' => case f(x) of
		  NONE => NONE
		| SOME (y::ys) => traverse(acc @ [y], xs')
  in 
    if aList = [] then SOME [] else traverse([], aList)
  end


fun count_wildcards p = 
  g (fn () => 1) (fn str => 0) p

fun count_wild_and_variable_lengths p = 
  g (fn () => 1) (fn str => String.size str) p

fun count_some_var (str, p) =
  g (fn () => 0) (fn x => if x = str then 1 else 0) p

fun check_pat p = 
  let 
    fun getStringVars p = 
      foldl (fn (a,b) => case a of Variable x => b @ [x] | _ => b) [] p 
    fun hasRepeats strList =
      case strList of 
        [] => false
      | x::xs => if List.exists (fn a => a = x) xs then true else hasRepeats xs
  in 
    (hasRepeats o getStringVars) p
  end



