#!/bin/bash
readonly ROWS=9
readonly EMPTY=1
declare -a gameBoard
count=0
choice=1
playerTurn=1
moves=0
boolean=5
position=-1
echo "Welcome to Tic Tac Toe Problem"
#initialize
initialize()
{
	position=0
}

#changePlayerTurn: To change player turn
changePlayerTurn()
{
	if [[ $playerTurn -eq 1 ]]
	then
		playerTurn=2
	else
		playerTurn=1
	fi
}
#resetTheBoard: To initialize gameBoard or for fresh start 
resetTheBoard()
{
	for ((i=0;i<$ROWS;i++))
	do
		gameBoard[$i]="-"
	done
}
	
#show: Letter and Turn assign 
show()
{
	echo "computerLetter: $computerLetter"
	echo "opponentLetter: $opponentLetter"
	echo "computerTurn: $computerTurn"
	echo "opponentTurn: $opponentTurn"
	echo
}
#assignedLetter: To assign letter X or O
assignedLetter()
{
	local randomNumber=$((RANDOM%2))
	if [[ $randomNumber -eq 0 ]]
	then
		opponentLetter="X"
		computerLetter="O"
		opponentTurn=1
		computerTurn=2
	else
		computerLetter="X"
		opponentLetter="O"
		computerTurn=1
		opponentTurn=2
	fi
	show
}
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
	if [[ $boolean -eq 5 ]]
	then	
		winningConditionOfRow $winsign
	fi
	if [[ $boolean -eq 5 ]]
	then
		winningConditionOfColumn $winsign
	fi
	if [[ $boolean -eq 5 ]]
	then
		winningConditionOfDiagonal $winsign
	fi
}
#displayWinner: Displaying winner
displayWinner()
{	
	winsign=$1
	isWinner #$winsign
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
	letter=$1
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

#computerSmartMoveForRow
computerSmartMoveForRow()
{
	flag=0
	letter=$1
	for ((i=0;i<9;i=i+3))
	do
		if [[ ${gameBoard[$i]} == $letter && ${gameBoard[$((i+1))]} == $letter && ${gameBoard[$((i+2))]} == "-" ]]	
		then 
			position=$((i+3)) 
			flag=1
			input $computerLetter
			break
		fi
		if [[ ${gameBoard[$i]} == "-" && ${gameBoard[$((i+1))]} == $letter && ${gameBoard[$((i+2))]} == $letter ]]	
		then 
			position=$((i+1)) 
			flag=1			
			input $computerLetter
			break
		fi
		if [[ ${gameBoard[$i]} == $letter && ${gameBoard[$((i+1))]} == "-" && ${gameBoard[$((i+2))]} == $letter ]]	
		then 
			position=$((i+2)) 
			flag=1
			input $computerLetter
			break
		fi
	done
}

computerSmartMoveForColumn()
{
	flag=0
	letter=$1
	for ((i=0;i<3;i++))
	do
		if [[ ${gameBoard[$i]} == $letter && ${gameBoard[$((i+3))]} == $letter && ${gameBoard[$((i+6))]} == "-" ]]	
		then 
			position=$((i+7)) 
			flag=1
			input $computerLetter
			break
		fi
		if [[ ${gameBoard[$i]} == "-" && ${gameBoard[$((i+3))]} == $letter && ${gameBoard[$((i+6))]} == $letter ]]	
		then 
			position=$((i+1)) 
			flag=1			
			input $computerLetter
			break
		fi
		if [[ ${gameBoard[$i]} == $letter && ${gameBoard[$((i+3))]} == "-" && ${gameBoard[$((i+6))]} == $letter ]]	
		then 
			position=$((i+4)) 
			flag=1
			input $computerLetter
			break
		fi
	done
}

computerSmartMoveForDiagonal()
{
	flag=0
	letter=$1
	if [[ ${gameBoard[0]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[8]} == "-" ]]
	then
		position=9
		flag=1
		input $computerLetter
	fi 
	if [[ ${gameBoard[0]} == $letter && ${gameBoard[4]} == "-" && ${gameBoard[8]} == $letter ]]
	then 
		position=5
		flag=1
		input $computerLetter
	fi
	if [[ ${gameBoard[0]} == "-" && ${gameBoard[4]} == $letter && ${gameBoard[8]} == $letter ]]
	then
		position=1
		flag=1
		input $computerLetter
	fi
	if [[ ${gameBoard[6]} == $letter && ${gameBoard[4]} == $letter && ${gameBoard[2]} == "-" ]]
	then 
		position=3
		flag=1
		input $computerLetter
	fi
	if [[ ${gameBoard[6]} == $letter && ${gameBoard[4]} == "-" && ${gameBoard[2]} == $letter ]]
	then 
		position=5
		flag=1
		input $computerLetter
	fi
	if [[ ${gameBoard[6]} == "-" && ${gameBoard[4]} == $letter && ${gameBoard[2]} == $letter ]]
	then 
		position=7
		flag=1
		input $computerLetter
	fi
	
}
computerSmartMove()
{
	k=0
	sign=$1
	computerSmartMoveForRow $sign
	if [[ $flag -eq 0 ]]
	then
		k=1
		computerSmartMoveForColumn $sign
	fi
	if [[ $flag -eq 0 ]]
	then
		k=1
		computerSmartMoveForDiagonal $sign
	fi		
}
#isCornerEmpty
isCornerEmpty()
{
	flag=0
	for (( i=0;i<$ROWS;i++ ))
	do
		if [[ $(( $i % 2 )) -eq 0 && ${gameBoard[$i]} == "-" ]]
		then
			position=$((i+1))
			input $computerLetter
			break
		fi
	done
}
isCenterEmpty()
{
	if [[ ${gameBoard[4]} == "-" ]]
	then
		position=5
		input $computerLetter
	fi
	input
}
#isSideEmpty
isSideEmpty()
{
	key=0
	flag=0
	for (( i=0 ;i<$ROWS;i++ ))
	do
		if [[ $(( $i % 2 )) -eq 1 && ${gameBoard[$i]} == "-"  ]]
		then
			position=$((i+1))
			input $computerLetter
		fi
	done
	input		
}
computerMove()
{	
	if [[ $position -eq 0 ]]
	then
		computerSmartMove $computerLetter	
	fi
	if [[ $position -eq 0 ]]
	then
		computerSmartMove $opponentLetter		
	fi
	if [[ $position -eq 0 ]]
	then
		isCornerEmpty	
	fi
	if [[ $position -eq 0 ]]
	then
		isCenterEmpty	
	fi
	if [[ $position -eq 0 ]]
	then
		isSideEmpty	
	fi
	if [[ $position -eq 0 ]]
	then
		position=$((RANDOM%9))
		input $computerLetter
	fi
}
#opponentMove
opponentMove()
{
	echo "Enter Your Move:"
	read position
	input $opponentLetter
}
#ticTacToe: Game
ticTacToe()
{
	count=0
	while [[ $choice -eq 1 ]]
	do	
		initialize	
		if [[ $playerTurn -eq $opponentTurn ]]
		then
			echo "***Opponent Move***"
			opponentMove			
		elif [[ $playerTurn -eq $computerTurn ]]
		then			
			echo "***Computer Move***"
				computerMove			
		fi
	done
}
#startGame: Initial conditions  
startGame()
{
	resetTheBoard
	assignedLetter
}
startGame
displayGameBoard
ticTacToe
