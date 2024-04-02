extends CharacterBody2D

const SPEED: int = 50
var state = NPC.State.ACTIVE

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D as NavigationAgent2D
@onready var ani_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var random_look_timer: Timer = get_node("RandomLookTimer")
@onready var target_walk_timer: Timer = get_node("TargetWalkTimer")
@onready var vending_machines: Array = get_tree().get_nodes_in_group("vending_machines")
var target_vending_machine

var idle_animations: Array[String] = ["idle_look_west", "idle_look_east", "idle_still_south", "idle_still_north"]
const directions = [
	"west",
	"northwest",
	"north",
	"northeast",
	"east",
	"southeast",
	"south",
	"southwest"
]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			nav_agent.target_position = get_global_mouse_position()
			state = NPC.State.ACTIVE
			
			
func _physics_process(delta: float) -> void:
	if state == NPC.State.ACTIVE:
		walk()
	elif state == NPC.State.WANDERING:
		# Choose random point in navigation region
		walk()
	else: # IDLE
		ani_sprite.stop()
		velocity = Vector2.ZERO
	move_and_slide()
	
func _process(delta: float) -> void:
	pass

func disable_npc() -> void:
	print("NPC Disabled\n")
	state = NPC.State.IDLE

func _on_navigation_agent_2d_target_reached():
	print("Reached Target")
	disable_npc()


func _on_navigation_agent_2d_navigation_finished():
	if target_vending_machine != null:
		target_vending_machine.queue_order()
	post_purchase()

func _ready() -> void:
	ani_sprite.play(idle_animations[randi_range(0, idle_animations.size() - 1)])
	random_look_timer.wait_time = randf_range(3, 7)
	random_look_timer.start()
	target_walk_timer.wait_time = 10
	target_walk_timer.start()

func _on_random_look_timer_timeout():
	random_look_timer.stop()
	ani_sprite.stop()
	# Make sure default animation begins with idle!
	if state == NPC.State.IDLE:
		var animation: String = idle_animations[randi_range(0, idle_animations.size() - 1)]
		ani_sprite.set_animation(animation)
		ani_sprite.play()
	random_look_timer.wait_time = randf_range(3, 7)
	random_look_timer.start()
	

func walk() -> void:
	var next_path_pos: Vector2 = nav_agent.get_next_path_position()
	var direction: Vector2     = global_position.direction_to(next_path_pos)
	var direction_id = int(8.0 * (direction.rotated(PI / 8.0).angle() + PI) / TAU)
	ani_sprite.set_animation("walk_" + directions[direction_id])
	ani_sprite.play()
	velocity = direction * SPEED


# Makes the NPC wander after buying something
func post_purchase():
	state = NPC.State.WANDERING
	nav_agent.target_position = position + Vector2(400, -20)


# Go to vending machine when timer is up # Note that if the NPC can't arrive in time this func
func _on_target_walk_timer_timeout():
	# Sort list of vending machines by distance
	vending_machines.sort_custom(func(a, b): return position.distance_to(a.position) < position.distance_to(b.position))
	
	# Choose randomly from 3 nearest vending machines
	target_vending_machine = vending_machines[randi_range(0, min(len(vending_machines) - 1, 2))]
	nav_agent.target_position = target_vending_machine.position
	state = NPC.State.ACTIVE
