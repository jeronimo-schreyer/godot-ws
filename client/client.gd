extends Control


export var host = "ws://localhost:3000/"

var _client = WebSocketClient.new()


func _ready():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")


func _connected(proto = ""):
	$"%RichTextLabel".text = "Connected with protocol: " + proto
	$"%Send Ping".disabled = false


func _closed(was_clean = false):
	$"%RichTextLabel".text += "\n" + "Closed, clean: " + ("true" if was_clean else "false")
	$"%Send Ping".disabled = true
	$"%Connect".disabled = false


func _on_data():
	$"%RichTextLabel".text += "\n" + _client.get_peer(1).get_packet().get_string_from_utf8()


func _process(delta):
	_client.poll()


func _on_Connect_pressed() -> void:
	$"%Connect".disabled = true
	if _client.connect_to_url(host) != OK:
		$"%RichTextLabel".text = "Unable to connect"
		$"%Connect".disabled = false


func _on_Send_Ping_pressed() -> void:
	_client.get_peer(1).put_packet("ping".to_utf8())
