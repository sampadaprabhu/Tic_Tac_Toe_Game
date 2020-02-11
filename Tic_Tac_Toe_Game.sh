#!/bin/bash -x
readonly ROWS=9

boolean=0
moves=0
choice=1
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

#Functions To Winner Or Tie
#winningConditionOfRow
winningConditionOfRow()
{
	win=$1
	num=""
	val=$win$win$win
	for ((i=0;i<3;i++))
	do
		j=0
		num=${gameBoard[$i]}${gameBoard[$((i+3))]}${gameBoard[$((i+6))]}
		if [[ "$num"  == "$val" ]]
		then 
			boolean=1
			break
		fi
	done
}
#winningConditionOfColumn				
winningConditionOfColumn()
{
	win=$1
	num=""
	val=$win$win$win
	for ((i=0;i<9;i=i+3))
	do
		j=0
		num=${gameBoard[$i]}${gameBoard[$((i+1))]}${gameBoard[$((i+2))]}
		if [[ "$num"  == "$val" ]]
		then 
			boolean=1
			break
		fi
	done
}
#winningConditionOfDiagonal
winningConditionOfDiagonal()
{
	win=$1
	num=""
	val=$win$win$win
	num=${gameBoard[0]}${gameBoard[4]}${gameBoard[8]}
	if [[ "$num" == "$val" ]]
	then 
		boolean=1
	fi
	num=${gameBoard[6]}${gameBoard[4]}${gameBoard[2]}
	if [[ "$num" == "$val" ]]
	then 
		boolean=1
	fi
}
#isWinner: Checking current player is winner or not
isWinner()
{
	if [[ $boolean -eq 0 ]]
	then	
		winningConditionOfRow $winsign
	fi
	if [[ $boolean -eq 0 ]]
	then
		winningConditionOfColumn $winsign
	fi
	if [[ $boolean -eq 0 ]]
	then
		winningConditionOfDiagonal $winsign
	fi
}
#displayWinner: Displaying winner
displayWinner()
{	
	winsign=$1
	isWinner
	if [[ $boolean -eq 1 && $playerTurn -eq $computerTurn ]]
	then
		echo "Computer wins...!!"
		choice=0
	elif [[ $boolean -eq 1 && $playerTurn -eq $opponentTurn ]]
	then
		echo "You wins...!!"
		choice=0
	fi		
}
#input: Assigning values to the gameBoard
input()
{
	if [[ $position -lt 1 || $position -gt 9 ]]
	then
		echo "Invalid Move"
	elif [[ ${gameBoard[$((position-1))]} == "-" ]]
	then
		((++moves))
		gameBoard[$((position-1))]=$letter
		displayGameBoard		
		displayWinner $letter
		changePlayerTurn
		if [[ $moves -ge 8 ]]
		then
			echo "It's a Tie"
			exit
		fi
	else 
		echo "Game Board Is Already Occupied!!"
		
	fi
}
input
