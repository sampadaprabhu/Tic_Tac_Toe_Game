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
	echo "Player: $player"
}
#assignedLetter: To assign letter X or O
assignedLetter()
{
	 toss=$((RANDOM%2))
	if [[ $toss -eq 0 ]]
	then
		letter="X"
		player=1
	else
		letter="O"
		player=1
	fi
	show
}
assignedLetter
