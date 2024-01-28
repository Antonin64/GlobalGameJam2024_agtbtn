extends Sprite2D

const bulletPath = preload('res://weapons/bullet.tscn')
const bulletPathRed = preload('res://weapons/red_bullet.tscn')
var hp = 3
var time_count = 0
var phase = 1
var attack_speed = 2
var rng = RandomNumberGenerator.new()
var time_anim = 0
var transition = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Animation.play("phase1", -1, 1, false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_anim += delta
	time_count += delta
	if transition:
		if time_anim > 8:
			hp = 3
			transition = false
			$GPUParticles2D.emitting = false
			$Animation.stop()
			get_node("../../CharacterBody2D").can_fart = true
			if phase == 2:
				$Animation.play("phase2", -1, 1, false)
				attack_speed = 1
			if phase == 3:
				$Animation.play("phase3", -1, 1, false)
				attack_speed = 0.5
			if phase == 4:
				print("LE BOSS EST MOOOORT")
				$Animation.stop()
				queue_free()
	else:
		if time_count > attack_speed:
			time_count = 0
			if phase == 1:
				fire_poop()
			if phase == 2:
				if rng.randi_range(0, 1) == 0:
					fire_poop()
				else:
					fire_poop_red()
			if phase == 3:
				if rng.randi_range(0, 5) == 0:
					fire_poop()
				else:
					fire_poop_red()

func fire_poop():
	var player_pos = get_parent().get_parent().get_node("CharacterBody2D").global_position
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.look_at(player_pos)
	bullet.global_position = self.global_position
	bullet.bullet_velocity = player_pos - self.global_position

func fire_poop_red():
	var player_pos = get_parent().get_parent().get_node("CharacterBody2D").global_position
	var bullet = bulletPathRed.instantiate()
	get_parent().add_child(bullet)
	bullet.look_at(player_pos)
	bullet.global_position = self.global_position
	bullet.bullet_velocity = player_pos - self.global_position

func lose_hp():
	hp -= 1
	$GPUParticles2D2.restart()
	if hp == 0:
		phase += 1
		time_anim = 0
		$Animation.play("inter_phase", -1, 1, false)
		transition = true
		$GPUParticles2D.emitting = true
		$transition_fart.play()
		Input.start_joy_vibration(0,1,1,8.0)
		get_node("../../CharacterBody2D").can_fart = false
