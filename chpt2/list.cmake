cmake_minimum_required(VERSION 3.20.0)

set(MyList "a;list;of;five;elements")
set(MyList a list "of;five;elements")
message("the list is: " ${MyList})

list(LENGTH MyList MyListLength)
message("the list length: " ${MyListLength})

list(GET MyList 0 MyListIndex0)
message("the list index 0: " ${MyListIndex0})

list(JOIN MyList "<glue>" MyListJoin)
message("the joined list is: " ${MyListJoin})

set(begin 0)
set(length 3)
list(SUBLIST MyList ${begin} ${length} MySubList)
message("the sub list is: " ${MySubList})

list(FIND MyList "list" ListIndex)
message("the list index is: " ${ListIndex})

list(APPEND MySubList a b c)
message("the appended list is: " ${MySubList})

list(FILTER MySubList EXCLUDE REGEX "[abc]")
message("the filtered list is: " ${MySubList})

list(INSERT MySubList 1 "new;sub")
message("the inserted list is: " ${MySubList})

list(POP_BACK MySubList back)
message("the poped back is: " ${back})

list(POP_FRONT MySubList front)
message("the poped front is: " ${front})

list(PREPEND MySubList a a new a sub)
message("the prepend list is: " ${MySubList})

list(REMOVE_ITEM MySubList sub)
message("the remove list is: " ${MySubList})

list(REMOVE_AT MySubList 1)
message("the remove list is: " ${MySubList})

list(REMOVE_DUPLICATES MySubList)
message("the remove list is: " ${MySubList})

list(REVERSE MySubList)
message("the reversed list is: " ${MySubList})

list(SORT MySubList)
message("the sorted list is: " ${MySubList})
