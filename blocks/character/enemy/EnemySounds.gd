extends Node

@export var body: CharacterBody3D
@export var box_receiver: BoxReceiver

@onready var randomizer = RandomNumberGenerator.new()

var mood: EnemyType.Mood

func _ready():
  var moods = [EnemyType.Mood.HAPPY, EnemyType.Mood.CREEPY, EnemyType.Mood.WEIRD]
  mood = Random.element(randomizer, moods)
  GameEvents.on_enemy_spawned.emit(body, mood)
  box_receiver.on_box_received.connect(func():GameEvents.on_package_delivered.emit(body.global_position, mood))
