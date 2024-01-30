@tool
@icon("./icon.svg")
class_name SubViewportContainerStretch
extends TextureRect
## Displays and stretches the contents of a [SubViewport] without affecting
## [member SubViewport.size].
##
## Displays the contents of the first underlying [SubViewport] child node. The
## [SubViewport]'s placement can be controlled with the [member
## TextureRect.stretch_mode] property.


var _sub_viewport: SubViewport


func _init() -> void:
	child_order_changed.connect(_on_child_order_changed)


func _input(event: InputEvent) -> void:
	if _sub_viewport:
		_sub_viewport.push_input(event)


func _get_configuration_warnings() -> PackedStringArray:
	if not _sub_viewport:
		return ["""This node doesn't have a SubViewport as a child, \
				so it can't display its intended content.
				Consider adding a SubViewport as a child \
				to provide something displayable."""
		]
	return []


func _update_sub_viewport() -> void:
	var sub_viewports: Array[Node] = find_children("", "SubViewport", false, false)
	_sub_viewport = null if sub_viewports.is_empty() else sub_viewports[0]
	texture = _sub_viewport.get_texture() if _sub_viewport else null
	update_configuration_warnings()


func _on_child_order_changed() -> void:
	_update_sub_viewport.call_deferred()
