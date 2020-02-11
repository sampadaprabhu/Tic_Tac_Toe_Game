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
#displayGameBoard: Displaying the gameBoard
displayGameBoard()
{
	echo "---------"
	echo "${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]}"
	echo "---------"
	echo "${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]}"
	echo "-------"
	echo "${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]}"
	echo "---------"
}
displayGameBoard
