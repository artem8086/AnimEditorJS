
selectedObj = null
props = $ '.js-obj-properties'

propsFields = null
propsBoolFields = null

selectObject = (options) ->
	selectedObj = obj = options.target
	props.empty()

	getProperties = (obj, array) ->
		for prop in Object.keys(obj)
			if array.indexOf(prop) < 0
				array.push prop
		proto = Object.getPrototypeOf obj
		if proto.constructor.name != 'Object'
			getProperties proto, array
		array

	for prop in getProperties(obj, []).sort()
		value = obj[prop]
		switch typeof value
			when 'boolean'
				props.append "<div class='input-group mb-1'>
						<input type='text' class='form-control bg-light' disabled  value='#{prop}'>
						<div class='input-group-append'>
							<div class='input-group-text'>
								<input type='checkbox' class='js-obj-prop js-prop-bool' data-name='#{prop}' #{if value then 'checked' else ''}>
							</div>
						</div>
					</div>"
			when 'string'
				props.append "<div class='input-group mb-1'>
						<div class='input-group-prepend'>
							<span class='input-group-text'>#{prop}</span>
						</div>
						<input type='text' class='form-control js-obj-prop js-prop-string' data-name='#{prop}' value='#{value}'>
					</div>"
			when 'number'
				props.append "<div class='input-group mb-1'>
						<div class='input-group-prepend'>
							<span class='input-group-text'>#{prop}</span>
						</div>
						<input type='number' class='form-control js-obj-prop js-prop-number' data-name='#{prop}' value='#{value}'>
					</div>"



	$('.js-prop-string').on 'input change', ->
		_this = $ this
		selectedObj?.set _this.data('name'), _this.val()

	$('.js-prop-number').on 'input change', ->
		_this = $ this
		selectedObj?.set _this.data('name'), + _this.val()

	$('.js-prop-bool').on 'input change', ->
		_this = $ this
		selectedObj?.set _this.data('name'), _this.prop('checked');

	propsFields = $ '.js-prop-string,.js-prop-number'
	propsBoolFields = $ '.js-prop-bool'

updateProperties = () ->
	obj = selectedObj
	if obj
		propsFields.each ->
			_this = $ this
			_this.val obj[_this.data 'name']
		propsBoolFields.each ->
			_this = $ this
			_this.prop 'checked', obj[_this.data 'name']

initSelection = (canvas) ->
	canvas.on 'object:selected', selectObject
	canvas.on 'object:modified', updateProperties

export { initSelection }