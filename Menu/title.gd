extends Control

var original_scale;
var target_scale = 1.5;
var animation_duration = 1.0;
var easing_type = Tween.TRANS_LINEAR;

func _ready():
	original_scale = rect_min_size;
	start_animation();

func start_animation():
	$Tween.interpolate_property(self, "rect_scale", original_scale, Vector2(target_scale, target_scale), animation_duration, easing_type, 0);
	$Tween.interpolate_property(self, "rect_scale", Vector2(target_scale, target_scale), original_scale, animation_duration, easing_type, animation_duration);
	$Tween.start();

func _on_Tween_tween_completed(object, key):
	start_animation();
