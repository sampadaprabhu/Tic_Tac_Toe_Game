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
