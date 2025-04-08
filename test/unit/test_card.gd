extends GutTest

class TestCardExists:
	extends GutTest
		
	func test_exists():
		var _card : Card = Card.new()
		assert_not_null(_card, "Object does not exist, is null")
		_card.free()


class TestCardNumberToRank:
	extends GutTest

	var _card : Card = null

	func before_each() -> void:
		_card = Card.new()

	func after_each() -> void:
		_card.free()
	
	func test_convert_1_to_A():
		assert_eq(_card.number_to_rank(1), "A", "Number 1 should be converted to A")
	
	func test_convert_less_than_1_to_A():
		assert_eq(_card.number_to_rank(0), "A", "Number 0 should be converted to A")
		assert_eq(_card.number_to_rank(-1), "A", "Number -1 should be converted to A")
		assert_eq(_card.number_to_rank(-3), "A", "Number -3 should be converted to A")
	
	func test_number_between_2_and_10_inclusive_not_convert():
		assert_eq(_card.number_to_rank(2), "2", "Number 2 should not be converted")
		assert_eq(_card.number_to_rank(3), "3", "Number 3 should not be converted")
		assert_eq(_card.number_to_rank(4), "4", "Number 4 should not be converted")
		assert_eq(_card.number_to_rank(5), "5", "Number 5 should not be converted")
		assert_eq(_card.number_to_rank(6), "6", "Number 6 should not be converted")
		assert_eq(_card.number_to_rank(7), "7", "Number 7 should not be converted")
		assert_eq(_card.number_to_rank(8), "8", "Number 8 should not be converted")
		assert_eq(_card.number_to_rank(9), "9", "Number 9 should not be converted")
		assert_eq(_card.number_to_rank(10), "10", "Number 10 should not be converted")
	
	func test_convert_11_to_J():
		assert_eq(_card.number_to_rank(11), "J", "Number 11 should be converted to J")
	
	func test_convert_12_to_Q():
		assert_eq(_card.number_to_rank(12), "Q", "Number 12 should be converted to Q")
	
	func test_convert_13_to_K():
		assert_eq(_card.number_to_rank(13), "K", "Number 13 should be converted to K")
	
	func test_convert_higher_than_13_to_K():
		assert_eq(_card.number_to_rank(14), "K", "Number 14 should be converted to K")
		assert_eq(_card.number_to_rank(15), "K", "Number 15 should be converted to K")
		assert_eq(_card.number_to_rank(18), "K", "Number 18 should be converted to K")


class TestCardGetRankableNumber:
	extends GutTest

	var _card : Card = null

	func before_each() -> void:
		_card = Card.new()

	func after_each() -> void:
		_card.free()
	
	func test_not_possible_get_random_less_than_1():
		for i in 100:
			assert_gt(_card.get_rankable_number(), 0, "Should not get less than 1")
	
	func test_not_possible_get_random_greater_than_13():
		for i in 100:
			assert_lt(_card.get_rankable_number(), 14, "Should not get greater than 13")
	
	func test_only_possible_get_random_between_1_and_13():
		var data = { }
		for i in 300:
			data[_card.get_rankable_number()] = true
		
		for i in range(1,14):
			assert_true(data[i], "Should found {i} in random pick")

class TestCardNumberToSuit:
	extends GutTest

	var _card : Card = null

	func before_each() -> void:
		_card = Card.new()

	func after_each() -> void:
		_card.free()
	
	func test_convert_1_to_diamonds():
		assert_eq(_card.number_to_suit(1), "Diamonds")
	
	func test_convert_2_to_clubs():
		assert_eq(_card.number_to_suit(2), "Clubs")
	
	func test_convert_3_to_hearts():
		assert_eq(_card.number_to_suit(3), "Hearts")
	
	func test_convert_4_to_spades():
		assert_eq(_card.number_to_suit(4), "Spades")

	func test_convert_less_than_1_to_diamonds():
		assert_eq(_card.number_to_suit(0), "Diamonds")
		assert_eq(_card.number_to_suit(-1), "Diamonds")
		assert_eq(_card.number_to_suit(-3), "Diamonds")

	func test_convert_greater_than_4_to_spades():
		assert_eq(_card.number_to_suit(5), "Spades")
		assert_eq(_card.number_to_suit(7), "Spades")
		assert_eq(_card.number_to_suit(86), "Spades")

class TestCardGetSuitableNumber:
	extends GutTest

	var _card : Card = null

	func before_each() -> void:
		_card = Card.new()

	func after_each() -> void:
		_card.free()
	
	func test_not_possible_get_random_less_than_1():
		for i in 100:
			assert_gt(_card.get_suitable_number(), 0, "Should not get less than 1")
	
	func test_not_possible_get_random_greater_than_4():
		for i in 100:
			assert_lt(_card.get_suitable_number(), 5, "Should not get greater than 4")
	
	func test_only_possible_get_random_between_1_and_4():
		var data = { }
		for i in 300:
			data[_card.get_suitable_number()] = true
		
		for i in range(1,5):
			assert_true(data[i], "Should found {i} in random pick")

class TestCardProcess:
	extends GutTest

	var _card : Card = null

	func before_each() -> void:
		_card = Card.new()

	func after_each() -> void:
		_card.free()
	
	func test_after_one_second_change_rank():
		var old_text : String = _card.text
		simulate(_card, 1, 1)
		assert_ne(old_text, _card.text, "Card should not be equal after 1 second")

		old_text = _card.text
		simulate(_card, 1, 1)
		assert_ne(old_text, _card.text, "Card should not be equal after 1 second")
	
	func test_after_half_second_not_change_rank():
		var old_text : String = _card.text
		simulate(_card, 1, 0.5)
		assert_eq(old_text, _card.text, "Card should be equal after 0.5 second")
	
	func test_text_show_suit_and_rank():
		simulate(_card, 1, 1)
		print(_card.text)
		assert_gt(_card.text.length(), 7) 

