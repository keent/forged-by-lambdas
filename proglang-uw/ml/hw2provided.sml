(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* add me on github.com/keent :) *)
fun all_except_option (str: string, strList: string list) = 
  let fun traverse(strList, accList) = 
    case strList of 
    [] => []
    | x::xs => if same_string(str, x) then accList @ xs else traverse(xs, accList @ [x])
  in
    case traverse(strList, []) of [] => NONE | x => SOME(x)
  end

fun all_except_option2 (str: string, strList: string list) = 
  let fun traverse(strList, accList) = 
    case strList of 
    [] => []
    | x::xs => if same_string(str, x) then accList @ xs else traverse(xs, accList @ [x])
  in
    let val ans = traverse(strList, [])
    in if ans = [] then NONE else SOME ans end
  end

fun get_substitutions1 (strListList: string list list, str: string) = 
  case strListList of
    [] => []
    | hd::tl => case all_except_option(str, hd) of
                   NONE => get_substitutions1 (tl, str)
                 | SOME(strList) => strList @ get_substitutions1 (tl, str)  

fun get_substitutions2 (strListList: string list list, str: string) = 
  let fun traverse(strListList: string list list, acc: string list) = 
    case strListList of
    [] => acc
    | hd::tl => case all_except_option(str, hd) of
		               NONE => traverse(tl, acc)
                 | SOME(strList) => traverse(tl, acc @ strList)  
  in
    traverse(strListList, [])
  end


fun similar_names (strListList: string list list, fullname: {first:string, middle:string, last:string}) =
  let val {first=fname, middle=mname, last=lname} = fullname
      val subList = get_substitutions2(strListList, fname)
      fun traverse (subList: string list, accFullNameList) = 
        case subList of
        [] => accFullNameList
        | hd::tl => traverse(tl, accFullNameList @ [{first=hd, middle=mname, last=lname}] )
  in 
    traverse(subList, [fullname])
  end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(inCard: card) = 
  case inCard of 
      (Clubs,_) => Black
    | (Spades,_) => Black
    | _ => Red

fun card_value(inCard: card) = 
  case inCard of
      (_, Jack) => 10
    | (_, Queen) => 10
    | (_, King) => 10
    | (_, Ace) => 11
    | (_, Num x) => x

fun remove_card(cs: card list, c: card, ex) = 
  let fun traverse(cs, accNewCards) = 
    case cs of 
    [] => []
    | x::xs => if c = x then accNewCards @ xs else traverse(xs, accNewCards @ [x])
  in
    case traverse(cs, []) of [] => raise ex | newcs => newcs
  end  

fun all_same_color(cs: card list) =
  case cs of
    [] => true
  | x::[] => true
  | head::(neck::rest) => if card_color(head) = card_color(neck) 
			  then all_same_color(neck::rest) 
			  else false

fun sum_cards(cs: card list) =
  let fun sum_cards_tl(cs, accSum) =
    case cs of
      [] => accSum
    | hd::tl => sum_cards_tl(tl, accSum + card_value(hd))
  in
    sum_cards_tl(cs, 0) 
  end

fun score(cs: card list, goal: int) = 
  let 
    val sum = sum_cards(cs)
    val prelim_score = if sum > goal then 3 * (sum - goal) else goal - sum
  in
    if all_same_color(cs) then (prelim_score div 2) else prelim_score
  end


fun officiate(cs: card list, mvList: move list, goal: int) = 
  let fun play(hldCards: card list, cs: card list, mvList: move list) = 
    case (hldCards, cs, mvList) of 
      (_, _, []) => score(hldCards, goal) 
    | (_, csX::csXS, mvX::mvXS) 
      => case mvX of
           Discard card => play(remove_card(hldCards, card, IllegalMove), cs, mvXS)
         | Draw => let val newcs = remove_card(cs, csX, IllegalMove)
		   in
	             case newcs of
		       [] => score(hldCards, goal)
		     | x::xs => if (sum_cards(hldCards) > goal)
				then score(hldCards, goal)
			        else play(csX::hldCards, csXS, mvXS)
		   end						
  in
    play([], cs, mvList)
  end
