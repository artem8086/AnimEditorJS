
$(document).ready ->
	canvas = new fabric.Canvas 'canvas'
	rect = new fabric.Rect
		left: 100
		top: 100
		fill: 'red'
		width: 20
		height: 20

	canvas.add rect

	resize = ->
		canvas.setWidth $(window).width()
		canvas.setHeight $(window).height() - $('#canvas-wrapper').offset().top

	do resize
	$(window).on "resize", resize

	$('.js-button-figure').click ->
		_this = $ this
		obj = new fabric[_this.data('obj')](JSON.parse(_this.data('prop').replace(/\'/g, '"')))
		canvas.add obj
		obj.center()

	data = [
		{name: 'node1', id: 1,
		children: [
			{ name: 'child1', id: 2 },
			{ name: 'child2', id: 3 }
		]},
		{name: 'node2',	id: 4,
		children: [
			{ name: 'child3', id: 5 }
		]}
	]
	$('.treeview').tree
		data: data
		autoOpen: true
		dragAndDrop: true