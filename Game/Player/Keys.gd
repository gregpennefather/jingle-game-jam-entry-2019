extends Item

export (int) var DEFAULT_NUMBER_OF_KEYS := 1

var keys_remaining := DEFAULT_NUMBER_OF_KEYS

func use_key() -> bool:
	print(keys_remaining)
	if keys_remaining > 0:
		keys_remaining -= 1
		print('key used')
		return true
	return false
