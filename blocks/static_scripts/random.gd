extends Node

class_name Random

static func vector(randomizer: RandomNumberGenerator) -> Vector3:
	var result = Vector3(randomizer.randf(), randomizer.randf(), randomizer.randf())
	return result