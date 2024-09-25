extends Node

var score : int = 0
var score_label : Label

func update_score(value: int):
    score += value
    if score_label:
        score_label.text = str(score)