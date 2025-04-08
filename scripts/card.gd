class_name Card
extends Label

var _timed : float = 0

var _ranks = {
	1:"A",
	11:"J",
	12:"Q",
	13:"K",
}

var _min_rank = 1
var _max_rank = 13

var _suits = {
	1:"Diamonds",
	2:"Clubs",
	3:"Hearts",
	4:"Spades"
}

var _min_suit = 1
var _max_suit = 4

func _process(delta: float) -> void:
	_timed += delta

	if _timed >= 1:
		text =  number_to_suit(get_suitable_number())+ " : " +number_to_rank(get_rankable_number())
		_timed -= 1

func get_rankable_number() -> int:
	return randi_range(_min_rank,_max_rank)

func number_to_rank(number : int) -> String:
	number = clamp(number, _min_rank, _max_rank)

	if _ranks.has(number):
		return _ranks[number]
	
	return str(number)

func get_suitable_number() -> int:
	return randi_range(_min_suit,_max_suit)

func number_to_suit(number: int) -> String:
	number = clamp(number, _min_suit, _max_suit)
	return _suits[number]