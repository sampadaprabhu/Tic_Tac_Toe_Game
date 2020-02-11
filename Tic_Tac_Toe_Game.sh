#!/bin/bash -x
readonly ROWS=9
declare -a gameBoard
echo "Welcome To Tic Tac Toe Game"
#resetTheBoard: To initialize gameBoard or for fresh start 
resetTheBoard()
{
	for ((i=0;i<$ROWS;i++))
	do
		gameBoard[$i]="-"
	done
}
resetTheBoard
#show: Letter and Turn assign 
show()
{
	echo "Letter: $letter"
}
#assignedLetter: To assign letter X or O
assignedLetter()
{
	local randomNumber=$((RANDOM%2))
	if [[ $randomNumber -eq 0 ]]
	then
		letter="X"
	else
		letter="O"
	fi
	show
}
assignedLetter
