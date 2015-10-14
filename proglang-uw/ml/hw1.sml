
fun is_older ( date1: int * int * int, date2: int * int * int) = 
  if (#1 date1) < (#1 date2)
  then true
  else if (#1 date1) = (#1 date2)
  then
    if (#2 date1) < (#2 date2)
    then true
    else if (#2 date1) = (#2 date2)
    then
      if (#3 date1) < (#3 date2)
      then true
      else false
    else false
  else false

fun number_in_month (dtList : (int * int * int) list, month : int) =
  if null dtList
  then 0
  else 
    let val total = number_in_month(tl dtList, month)
    in
      if (#2 (hd dtList)) = month
      then (total + 1)
      else total
    end

fun number_in_months (dtList : (int * int * int) list, monthList : int list) = 
  if null monthList
  then 0
  else 
    let val total = number_in_months(dtList, tl monthList)
    in 
      let val ret = number_in_month(dtList, hd monthList)
      in 
        (total + ret)
      end
    end

fun dates_in_month (dtList: (int * int * int) list, month: int) = 
  if null dtList
  then []
  else 
    let val finalDtList = dates_in_month(tl dtList, month)
    in
      if (#2 (hd dtList)) = month
      then (hd dtList) :: finalDtList
      else finalDtList
  end

fun dates_in_months (dtList: (int * int * int) list, monthList : int list) = 
  if null monthList
  then []
  else
    let val finalDateList = dates_in_months(dtList, tl monthList)
    in
      let val monthDates = dates_in_month(dtList, hd monthList)
      in finalDateList @ monthDates
      end
    end

fun get_nth (stList: string list, n: int) = 
  if n = 1
  then hd stList
  else get_nth(tl stList, n - 1)


fun date_to_string (dt: (int * int * int)) = 
  let 
    val months = ["January", "February", "March", "April", "May", "June", 
		  "July", "August", "September", "October", "November", "December"]
    val strMonth = get_nth(months, #2 dt)
    val strDate =  strMonth ^ " " ^ (Int.toString (#3 dt)) ^ ", " ^ (Int.toString (#1 dt))
  in
    strDate
  end


fun number_before_reaching_sum (sum: int, intList: int list) = 
  let fun traverse (sumCounter: int, intList: int list) = 
    let val sumCounter = sumCounter + (hd intList)
    in 
      if sumCounter >= sum
      then 0
      else 1 + traverse (sumCounter, tl intList)
    end
  in 
    traverse (0, intList)
  end

fun what_month (day: int) = 
  let val monthEnds = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
    number_before_reaching_sum(day, monthEnds) + 1
  end

fun month_range (day1: int, day2: int) = 
  if day1 > day2
  then []
  else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest (dateList: (int * int * int) list) = 
  if null dateList
  then NONE
  else
    let val oldestDate = oldest(tl dateList)
    in if isSome oldestDate andalso (is_older(valOf oldestDate, hd dateList))
      then oldestDate
      else SOME (hd dateList)
    end



fun number_in_months