extends Node

@export var body: CharacterBody3D

@onready var randomizer = RandomNumberGenerator.new()

var mood: EnemyType.Mood

func _ready():
  var moods = [EnemyType.Mood.HAPPY, EnemyType.Mood.CREEPY, EnemyType.Mood.WEIRD]
  mood = Random.element(randomizer, moods)
  GameEvents.on_enemy_spawned.emit(body, mood)

