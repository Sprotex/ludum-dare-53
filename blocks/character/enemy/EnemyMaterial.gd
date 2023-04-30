extends Node

@export var block_dude_relay: BlockDudeRelay
@export var material: Material

func _ready():
  block_dude_relay.mesh.material_override = material