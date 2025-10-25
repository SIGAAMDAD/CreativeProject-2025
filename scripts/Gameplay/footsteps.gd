class_name Footsteps extends Node

const MAX_STEPS: int = 24

# don't ask...
var _feet_buffer: Array[ Transform2D ]
var _multimesh: MultiMeshInstance2D

func _check_capacity() -> void:
	if _feet_buffer.size() < MAX_STEPS:
		return
	
	_feet_buffer.pop_front()
	
	var _instance: int = 0
	for step in _feet_buffer:
		_multimesh.multimesh.set_instance_transform_2d( _instance, step )
		_instance += 1
	
	_multimesh.multimesh.visible_instance_count -= 1


func add_step() -> void:
	var _position: Vector2 = get_parent().global_position
	var _transform: Transform2D = Transform2D(
		0.0,
		Vector2( _position.x, _position.y + 24.0 )
	)
	_check_capacity()
	_multimesh.multimesh.visible_instance_count += 1
	_multimesh.multimesh.set_instance_transform_2d( _feet_buffer.size(), _transform )
	_feet_buffer.push_back( _transform )


func _ready() -> void:
	_multimesh = MultiMeshInstance2D.new()
	_multimesh.visibility_layer = 1
	_multimesh.name = "MeshManager"
	_multimesh.texture = load( "res://textures/footstep.png" )
	_multimesh.modulate = Color( 1.0, 1.0, 1.0, 0.75 )
	_multimesh.multimesh = MultiMesh.new()
	_multimesh.multimesh.mesh = QuadMesh.new()
	_multimesh.multimesh.mesh.size = Vector2( 16.0, -8.0 )
	_multimesh.multimesh.visible_instance_count = 0
	_multimesh.multimesh.instance_count = MAX_STEPS
	add_child( _multimesh )
