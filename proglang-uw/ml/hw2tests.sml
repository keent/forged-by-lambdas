all_except_option("gran", ["gran"]);
all_except_option("gran", ["gran", "ville", "van"]);
all_except_option("ville", ["gran", "ville", "van"]);
all_except_option("van", ["gran", "ville", "van"]);
all_except_option("gran", ["ville", "van", "lintao"]);

all_except_option2("gran", ["gran", "ville", "van"]);
all_except_option2("ville", ["gran", "ville", "van"]);
all_except_option2("van", ["gran", "ville", "van"]);
all_except_option2("gran", ["ville", "van", "lintao"]);

get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred");
get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff");

get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred");
get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff");

similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], 
	      {first="Fred", middle="W", last="Smith"});
