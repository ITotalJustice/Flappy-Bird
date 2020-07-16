extends Control


func setup(score: int):
	var new_highscore := Global.new_score(score)
	if new_highscore:
		$New.show()
	$Score.text = String(score)
	$Best.text = String(Global.highscore)
	show()
