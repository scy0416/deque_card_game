extends Node2D

enum pattern {Spade, Diamond, Heart, Clover}
var pattern_str = ['Spade', 'Diamond', 'Heart', 'Clover']
enum num {A, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, J, Q, K}
var num_str = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, pattern.size()):
		for j in range(0, num.size()):
			print(pattern_str[i]+'-'+num_str[j])
