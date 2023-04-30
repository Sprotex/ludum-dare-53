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

@export var box_created_sounds: Array[AudioStream]
@export var box_throw_sounds: Array[AudioStream]
@export var box_small_impacts: Array[AudioStream]
@export var box_big_impacts: Array[AudioStream]

@export var jump_sounds: Array[AudioStream]

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



func play_mood_enemy_box_received(audio_position: Vector3, mood: EnemyType.Mood) -> void:
  var streams = happy_enemy_package_received_sounds
  match mood:
    EnemyType.Mood.CREEPY:
      streams = creepy_enemy_package_received_sounds
    EnemyType.Mood.WEIRD:
      streams = weird_enemy_package_received_sounds
  play_random_sound(streams, audio_position)
  
      
func play_box_impact(audio_position: Vector3, velocity: Vector3) -> void:
  var big_impact_velocity = 5.0
  var big_impact_velocity_squared = big_impact_velocity * big_impact_velocity
  var impact_sounds = box_small_impacts
  if velocity.length_squared() >= big_impact_velocity_squared:
    impact_sounds = box_big_impacts
  play_random_sound(impact_sounds, audio_position)


func attach_sound_to_event(_signal: Signal, sounds: Array[AudioStream]) -> void:
  GameEvents.connect(_signal.get_name(), func(audio_position): play_random_sound(sounds, audio_position))


func _ready():
  music_player.play()
  attach_sound_to_event(GameEvents.on_stepped, steps) 
  attach_sound_to_event(GameEvents.on_box_thrown, box_throw_sounds)
  attach_sound_to_event(GameEvents.on_box_created, box_created_sounds)
  attach_sound_to_event(GameEvents.on_jumped, jump_sounds)
  GameEvents.on_box_collided.connect(play_box_impact)
  GameEvents.on_package_delivered.connect(play_mood_enemy_box_received)
  GameEvents.on_enemy_spawned.connect(play_mood_enemy_spawn, CONNECT_DEFERRED)
