extends Node3D

@export var music_player: AudioStreamPlayer
@export var audio_players: AudioPlayers
@export var important_audio_players: AudioPlayers

@export var steps: Array[AudioStream]

@export var happy_enemy_spawn_sounds: Array[AudioStream]
@export var happy_enemy_package_received_sounds: Array[AudioStream]

@export var creepy_enemy_spawn_sounds: Array[AudioStream]
@export var creepy_enemy_package_received_sounds: Array[AudioStream]

@export var weird_enemy_spawn_sounds: Array[AudioStream]
@export var weird_enemy_package_received_sounds: Array[AudioStream]

@export var box_throw_sounds: Array[AudioStream]

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


func play_mood_enemy_spawn(node: Node3D, mood: EnemyType.Mood) -> void:
  var streams = happy_enemy_spawn_sounds
  match mood:
    EnemyType.Mood.CREEPY:
      streams = creepy_enemy_spawn_sounds
    EnemyType.Mood.WEIRD:
      streams = weird_enemy_spawn_sounds
  play_random_important_sound(streams, node)



func play_mood_enemy_box_received(position: Vector3, mood: EnemyType.Mood) -> void:
  var streams = happy_enemy_package_received_sounds
  match mood:
    EnemyType.Mood.CREEPY:
      streams = creepy_enemy_package_received_sounds
    EnemyType.Mood.WEIRD:
      streams = weird_enemy_package_received_sounds
  play_random_sound(streams, position)
  
      
func _ready():
  music_player.play()
  GameEvents.on_stepped.connect(func(audio_position): play_random_sound(steps, audio_position)) 
  GameEvents.on_enemy_spawned.connect(play_mood_enemy_spawn, CONNECT_DEFERRED)
  GameEvents.on_package_delivered.connect(play_mood_enemy_box_received)
  GameEvents.on_box_thrown.connect(func(audio_position): play_random_sound(box_throw_sounds, audio_position))
