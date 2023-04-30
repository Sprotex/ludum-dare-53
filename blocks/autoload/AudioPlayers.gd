extends Node3D

class_name AudioPlayers

@export var count = 8
@export var bus = "Sound"
var players: Array[AudioStreamPlayer3D]
var last_index = 0

class QueuedSound:
  var node: Node3D
  var audio_stream: AudioStream

func _ready():
  for i in count:
    var player = AudioStreamPlayer3D.new()
    add_child(player)
    player.bus = bus
    players.append(player)


func play_sound(audio_stream: AudioStream, audio_position: Vector3) -> AudioStreamPlayer3D:
  last_index += 1
  if last_index >= count:
    last_index = 0
  var current_player = players[last_index]
  current_player.global_position = audio_position
  current_player.stream = audio_stream
  current_player.play()
  return current_player

  
func play_important_sound(audio_stream: AudioStream, node: Node3D) -> void:
  var current_player = play_sound(audio_stream, node.global_position)
  var remote_transform = RemoteTransform3D.new()
  remote_transform.update_position = true
  remote_transform.update_rotation = false
  remote_transform.update_scale = false
  remote_transform.use_global_coordinates = true
  remote_transform.remote_path = current_player.get_path()
  node.add_child(remote_transform)


func kill_all_sounds() -> void:
  for child in get_children():
    child.stop()