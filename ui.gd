class_name UI
extends Control

@onready var ScoreLabel: Label = $Score
@onready var PausedLabel: Label = $PausedLabel
@onready var GameOverGroup: Control = $GameOver
@onready var GameOverMessage: Label = $GameOver/Message
@onready var RestartButton: Button = $GameOver/RestartButton
@onready var ReturnToPlayLabel: Label = $ReturnToPlayLabel
@onready var WorldNode: World = $World

var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var game_paused: bool = false
var game_pausable: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_resume") and game_pausable:
		game_paused = not game_paused
		WorldNode.set_pause(game_paused)
		PausedLabel.visible = game_paused


func _input(event: InputEvent) -> void:
	if GameOverGroup.visible:
		if event.is_action("ui_accept"):
			new_game()
		if event.is_action("ui_cancel"):
			get_tree().quit()


func new_game() -> void:
	set_score(0)
	GameOverGroup.visible = false
	game_pausable = true
	game_paused = false
	WorldNode.reset()


func set_score(new_score: int) -> void:
	score = new_score
	ScoreLabel.text = "Score: %s" % score


func game_over() -> void:
	game_pausable = false
	WorldNode.set_pause(true)
	ReturnToPlayLabel.visible = false
	GameOverGroup.visible = true


func _on_world_score_point() -> void:
	set_score(score + 1)


func _on_world_game_over() -> void:
	game_over()


func _on_restart_button_pressed() -> void:
	new_game()


func _on_world_left_world() -> void:
	ReturnToPlayLabel.visible = true


func _on_world_reentered_world() -> void:
	ReturnToPlayLabel.visible = false
