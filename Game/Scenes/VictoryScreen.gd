extends Node2D

func _ready():
	$PlayerBody.Armoured = PlayerStats.Armour
	$PlayerBody.HasSword = PlayerStats.Sword
	
	var number_saved := 0
	
	if not PlayerStats.Armour:
		number_saved += 1
		print('show knight')
		$Knight.show()
		$Knight.is_armoured = true
		$Knight.play_victory()
	else:
		$Knight.hide()

	if not PlayerStats.Sword:
		number_saved += 1
		print('show dwarf')
		$Dwarf.show()
		$Dwarf.has_sword = true
		$Dwarf.play_victory()
	else:
		$Dwarf.hide()

	if not PlayerStats.Boots:
		number_saved += 1
		print('show elf')
		$Elf.show()
		$Elf.play_victory()
	else:
		$Elf.hide()

	if  PlayerStats.RogueSaved:
		number_saved += 1
		print('show Rogue')
		$Rogue.show()
	else:
		$Rogue.hide()
		
	if PlayerStats.OldManSaved:
		number_saved += 1
		print('show OldMan')
		$OldMan.show()
	else:
		$OldMan.hide()	
			
	if PlayerStats.WimpSaved:
		number_saved += 1
		print('show Wimp')
		$Wimp.show()
		$Wimp.play_victory()
	else:
		$Wimp.hide()	
			
	if not PlayerStats.ResurrectionRing:
		number_saved += 1
		print('show Wizard')
		$Wizard.show()
		$Wizard.play_victory()
	else:
		$Wizard.hide()
		
	if number_saved > 0:
		$PlayerBody.play_victory()
		if number_saved == 1:
			$EscapedLabel2.text = "You escaped - and so did 1 other. If you had given up a little more the others might have made it."
		elif number_saved != 7:
			$EscapedLabel2.text = "You escaped - and so did %s others. If you had given up a little more the others might have made it." %str(number_saved)
		else:
			$Button.hide()
			$EscapedLabel2.text = "You escaped - and so did everyone else! You truely are a generous hero."
