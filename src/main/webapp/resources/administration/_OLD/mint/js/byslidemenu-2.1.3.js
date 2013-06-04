/*
Copyright (c) 2010, ByScripts.info
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
	* Redistributions of source code must retain the above copyright
	  notice, this list of conditions and the following disclaimer.
	* Redistributions in binary form must reproduce the above copyright
	  notice, this list of conditions and the following disclaimer in the
	  documentation and/or other materials provided with the distribution.
	* Neither the name of ByScripts.info nor the
	  names of its contributors may be used to endorse or promote products
	  derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL BYSCRIPTS.INFO BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var BySlideMenu = new Class({

	Implements: Options,

	options: {
		'container'			: 'byslidemenu',
		'selector'			: 'img',
		'compressSize'		: 50,
		'vertical'			: false,
		'skipClass'			: 'skip',
		'defaultClass'		: 'default',
		'triggerSelector'	: '.trigger',
		'eventType'			: 'mouseenter',
		'autoRestore'		: true,
		'onStart'			: $empty,
		'onComplete'		: $empty,
		'onRestore'			: $empty,
		'autoSlide'			: false,
		'autoSlideDelay' 	: 3000,
		'fxOptions': {
			'duration'		: 300,
			'transition'	: 'linear'
		}
	},

	elements: null,
	current_index: null,
	skipped_indexes: [],
	animation_datas: {},
	fx: null,
	paused: false,

	initialize: function(options) {
		this.setOptions(options);

		var menu = $(this.options.container);
		this.elements = menu.getElements(this.options.selector);
		var elements_count = this.elements.length; console.log(this.elements[0]);

		var element_width = this.elements[0].getWidth();
		var element_height = this.elements[0].getHeight();

		var menu_width = element_width;
		var menu_height = element_height;
		
		if (this.options.vertical) {
			var style_name = 'top';
			var element_size = element_height;
			var menu_height = element_height + ((elements_count - 1) * this.options.compressSize);
			var menu_size = menu_height;
		}
		else {
			var style_name = 'left';
			var element_size = element_width;
			var menu_width = element_width + ((elements_count - 1) * this.options.compressSize);
			var menu_size = menu_width;
		}

		menu.setStyles({
			'width'		: menu_width,
			'height'	: menu_height
		});

		var fx_options = $H({
			'link' : 'cancel'
		}).extend(this.options.fxOptions).getClean();

		this.fx = new Fx.Elements(this.elements, fx_options);

		for (i = -1; i < elements_count; i++) {

			this.animation_datas[i] = {};

			for (j = 0; j < elements_count; j++) {

				this.animation_datas[i][j] = {};

				if (i == -1) this.animation_datas[i][j][style_name] = j * (menu_size / elements_count);
				else this.animation_datas[i][j][style_name] = j * this.options.compressSize + (j > i ? element_size - this.options.compressSize : 0);
			}
		}

		var default_index = -1;

		this.elements.each(function(element, index) {

			var trigger = this.options.triggerSelector ? element.getElement(this.options.triggerSelector) : element;
			trigger = trigger ? trigger : element;

			element.setStyle(style_name, index * this.options.compressSize);

			if (!element.hasClass(this.options.skipClass)) {
				trigger.addEvent(this.options.eventType, function() {
					this.showIndex(index);
				}.bind(this));
			}
			else {
				this.skipped_indexes.include(index);
			}

			if (element.hasClass(this.options.defaultClass)) default_index = index;
		}, this);

		if (this.options.autoRestore) {
			menu.addEvent('mouseleave', function() {
				this.showIndex(default_index);
			}.bind(this));
		}

		this.showIndex(default_index);

		if (this.options.autoSlide) {
			menu.addEvent('mouseover', this.pause.pass(true, this))
				.addEvent('mouseout', this.pause.pass(false, this));

			this.slideNext.periodical(1000, this);
		}
	},

	pause: function(flag) {
		this.paused = flag;
	},

	slideNext: function() {

		if (this.paused) return;

		var next_index = this.current_index + 1;
		
		if (next_index >= this.elements.length)
		{
			next_index = 0;
		}
		
		while(this.skipped_indexes.contains(next_index))
		{
			next_index++;
		}

		

		this.showIndex(next_index);

	},

	showIndex: function(index) {

		var old_index = this.current_index;
		var old_element = this.elements[old_index];

		this.current_index = index;
		var element = this.elements[index];

		if (index != old_index) {
			this.options.onStart(element, index);
			this.options.onRestore(old_element, old_index);
			this.fx.start(this.animation_datas[index]).chain(this.options.onComplete.pass([element, index]));
		}
	}
});