is_older ( (2013, 2, 12), (2013, 2, 12));
is_older ( (2013, 2, 12), (2013, 2, 11));
is_older ( (2013, 2, 12), (2013, 2, 13));
is_older ( (2013, 2, 12), (2014, 2, 13));
is_older ( (2013, 2, 12), (2010, 2, 13));

number_in_month( [ (2012, 12, 1),
		   (2012, 12, 2),
		   (2012, 11, 0)
		 ], 12);

number_in_months( [ (2012, 11, 1),
		   (2012, 10, 1),
		   (2012, 9, 0)
		 ], 
                 [7, 12]);

dates_in_month ( [ (2012, 11, 1),
		   (2012, 11, 2),
		   (2012, 12, 3),
		   (2012, 10, 3),
		   (2012, 12, 3)
		 ], 11);


dates_in_months ( [ (2012, 11, 1),
		   (2012, 11, 2),
		   (2012, 12, 3),
		   (2012, 10, 3),
		   (2012, 12, 3)
		 ], 
		[7, 12, 10]);


get_nth(["hahaha", "hehehe", "hihihi"], 1);
get_nth(["hahaha", "hehehe", "hihihi"], 2);
get_nth(["hahaha", "hehehe", "hihihi"], 3);

date_to_string(2012, 1, 20);
date_to_string(2013, 1, 22);
date_to_string(2013, 3, 12);
date_to_string(2013, 11, 12);
date_to_string(2013, 12, 25);
date_to_string(2013, 6, 22);

number_before_reaching_sum(3, [3,2,1]);
number_before_reaching_sum(2, [3,2,1]);
number_before_reaching_sum(1, [3,2,1]);
number_before_reaching_sum(5, [3,2,1]);
(* number_before_reaching_sum(6, [3,2,1]); *)

what_month(365);
what_month(31);
what_month(32);
what_month(254);

month_range(31, 75);
month_range(59, 120);

oldest([(2012, 7, 31),
	(2012, 12, 28),
	(2012, 12, 27),
	(2012, 6, 25),
	(2012, 12, 20),
	(2012, 5, 2)
]);
