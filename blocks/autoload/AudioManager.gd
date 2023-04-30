extends Node3D

@export var music_player: AudioStreamPlayer
@export var audio_players: AudioPlayers
@export var important_audio_players: AudioPlayers

@export var steps: Array[AudioStream]

@onready var randomizer = RandomNumberGenerator.new()


func play_sound(sound: AudioStream, audio_position: Vector3) -> void:
  audio_players.play_sound(sound, audio_position)


func play_important_sound(sound: AudioStream, node: Node3D) -> void:
  important_audio_players.play_important_sound(sound, node)


func play_random_sound(streams: Array[AudioStream], audio_position: Vector3) -> void:
  var stream = Random.element(randomizer, streams)
  play_sound(stream, audio_position)


func play_random_important_sound(streams: Array[AudioStream], node: Node3D) -> void:
  var stream = Random.element(randomizer, streams)
  play_important_sound(stream, node)


func _ready():
  music_player.play()
  GameEvents.on_stepped.connect(func(audio_position): play_random_sound(steps, audio_position)) 
