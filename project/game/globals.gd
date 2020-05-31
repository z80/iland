
extends Node

const _VERSION: String = "0.9.0"
const _TABLET: bool = false
const _DEMO: bool   = false


func demo() -> bool:
	var d: bool = _DEMO and (not _TABLET)
	return d
	
func touch_controls() -> bool:
	return _TABLET

func version() -> String:
	return _VERSION


