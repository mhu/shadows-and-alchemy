extends Node


var start_time: float = 0
var end_time: float = 0


func start_timer() -> void:
    start_time = Time.get_unix_time_from_system()


func stop_timer() -> void:
    end_time = Time.get_unix_time_from_system()


func get_elapsed_time() -> float:
    return end_time - start_time
