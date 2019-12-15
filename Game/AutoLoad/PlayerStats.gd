extends Node

signal player_items_changed

var Armour : bool = true
var Boots : bool = true
var Sword : bool = true
var Keys : int = 3
var KeysUsed: int = 0
var ResurrectionRing : bool = true
var RespawnPosition: Vector2 = Vector2(-24, 272)
var RogueSaved: bool = false
var OldManSaved: bool = false
var WimpSaved: bool = false
var SaveSelfOnlyPath: bool = true

func reset():
	Armour = true
	Boots = true
	Sword = true
	Keys = 3
	KeysUsed = 0
	ResurrectionRing = true
	RespawnPosition = Vector2(-24, 272)
	RogueSaved = false
	OldManSaved = false
	WimpSaved = false
	SaveSelfOnlyPath = false
