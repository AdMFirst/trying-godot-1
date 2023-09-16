extends RichTextLabel

func _process(delta):
	text = "Coin: " + str(Game.playerGold)
