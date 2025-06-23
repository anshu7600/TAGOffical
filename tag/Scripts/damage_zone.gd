extends Area2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("play_hurt"):
		if (body != GameManager.playerReference[GameManager.tagger_index]):
			audio_stream_player_2d.play()
			body.play_hurt()
	else:
		print("Body does not have play_hurt method!")
