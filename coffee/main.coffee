import { initSelection } from './select'

$(document).ready ->
	canvas = new fabric.Canvas 'canvas'

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

	codemirror = CodeMirror.fromTextArea(document.getElementById('codearea'),
		extraKeys:
			'Ctrl-Space': 'autocomplete'
		mode:
			name: 'javascript'
			globalVars: true)

	$('.js-code-excec-btn').click ->
		obj = eval codemirror.getValue()
		canvas.add obj
		obj.center()

	initSelection(canvas)

	render = (delta) ->
		canvas.renderAll()
		window.requestAnimationFrame render
	render(0)