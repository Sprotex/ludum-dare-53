extends Node

class_name Random

static func vector(randomizer: RandomNumberGenerator) -> Vector3:
	var result = Vector3(randomizer.randf(), randomizer.randf(), randomizer.randf())
	return result


static func element(randomizer: RandomNumberGenerator, elements: Array[Variant]) -> Variant:
	var index = randomizer.randi_range(0, elements.size() - 1)
	var result = elements[index]
	return result