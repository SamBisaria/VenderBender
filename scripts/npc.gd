extends CharacterBody2D

const SPEED: int = 50
var active: bool = false

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			nav_agent.target_position = get_global_mouse_position()
			active = true
			
func _physics_process(delta: float) -> void:
	if active:
		var next_path_pos: Vector2 = nav_agent.get_next_path_position()
		var direction: Vector2     = global_position.direction_to(next_path_pos)
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func disable_npc() -> void:
	print("NPC Disabled\n")
	active = false

func _on_navigation_agent_2d_target_reached():
	print("Reached Target")
	disable_npc()


func _on_navigation_agent_2d_navigation_finished():
	print("Navigation Finished")
	disable_npc()
