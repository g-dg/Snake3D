extends Control

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var game_paused = false
var game_pausable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause_resume") and game_pausable:
		game_paused = not game_paused
		$World.set_pause(game_paused)
		$PausedLabel.visible = game_paused


func _input(event):
	if $GameOver.visible:
		if event.is_action("ui_accept"):
			new_game()
		if event.is_action("ui_cancel"):
			get_tree().quit()


func new_game():
	set_score(0)
	$GameOver.visible = false
	game_pausable = true
	game_paused = false
	$World.reset()


func set_score(new_score):
	score = new_score
	$Score.text = "Score: %s" % score


func game_over():
	game_pausable = false
	$World.set_pause(true)
	$ReturnToPlayLabel.visible = false
	$GameOver.visible = true


func _on_world_score_point():
	set_score(score + 1)


func _on_world_game_over():
	game_over()


func _on_restart_button_pressed():
	new_game()


func _on_world_left_world():
	$ReturnToPlayLabel.visible = true


func _on_world_reentered_world():
	$ReturnToPlayLabel.visible = false
