/*
---
name: Form.Check
description: Class to represent a checkbox
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event]
provides: Form.Check
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.Check = new Class({
  Implements: [Events, Options],
  options: {
    checked: false,
    disabled: false
  },
  bound: {},
  checked: false,
  config: {
    checkedClass: 'checked',
    disabledClass: 'disabled',
    elementClass: 'check',
    highlightedClass: 'highlighted',
    storage: 'Form.Check::data'
  },
  disabled: false,
  element: null,
  input: null,
  label: null,
  value: null,
  initialize: function(input, options) {
    this.setOptions(options);
    this.bound = {
      disable: this.disable.bind(this),
      enable: this.enable.bind(this),
      highlight: this.highlight.bind(this),
      removeHighlight: this.removeHighlight.bind(this),
      keyToggle: this.keyToggle.bind(this),
      toggle: this.toggle.bind(this)
    };
    var bound = this.bound;
    input = this.input = document.id(input);
    var id = input.get('id');
    this.label = document.getElement('label[for=' + id + ']');
    this.element = new Element('div', {
      'class': input.get('class') + ' ' + this.config.elementClass,
      id: id ? id + 'Check' : '',
      events: {
        click: bound.toggle,
        mouseenter: bound.highlight,
        mouseleave: bound.removeHighlight
      }
    });
    this.input.addEvents({
      keypress: bound.keyToggle,
      keydown: bound.keyToggle,
      keyup: bound.keyToggle
    });
    if (this.label) { this.label.addEvent('click', bound.toggle); }
    
    //Wiz
    var myLabel = input.getNext('label');
    //
    
    this.element.wraps(input);
    
    //Wiz
    this.element.grab(myLabel);
    //
    
    this.value = input.get('value');
    if (this.options.checked) { this.check(); } else { this.uncheck(); }
    if (this.options.disabled) { this.disable(); } else { this.enable(); }
    input.store(this.config.storage, this).addEvents({
      blur: bound.removeHighlight,
      focus: bound.highlight
    });
    this.fireEvent('create', this);
  },
  check: function() {
    this.element.addClass(this.config.checkedClass);
    this.input.set('checked', 'checked').focus();
    this.checked = true;
    this.fireEvent('check', this);
  },
  disable: function() {
    this.element.addClass(this.config.disabledClass);
    this.input.set('disabled', 'disabled');
    this.disabled = true;
    this.fireEvent('disable', this);
  },
  enable: function() {
    this.element.removeClass(this.config.disabledClass);
    this.input.erase('disabled');
    this.disabled = false;
    this.fireEvent('enable', this);
  },
  highlight: function() {
    this.element.addClass(this.config.highlightedClass);
    this.fireEvent('highlight', this);
  },
  removeHighlight: function() {
    this.element.removeClass(this.config.highlightedClass);
    this.fireEvent('removeHighlight', this);
  },
  keyToggle: function(e) {
    var evt = new Event(e);
    if (evt.key === 'space') { this.toggle(e); }
  },
  toggle: function(e) {
    var evt;
    if (this.disabled) { return this; }
    if (e) {
      evt = new Event(e).stopPropagation();
      if (evt.target.tagName.toLowerCase() !== 'a') {
        evt.stop();
      }
    }
    if (this.checked) {
      this.uncheck();
    } else {
      this.check();
    }
    this.fireEvent('change', this);
    return this;
  },
  uncheck: function() {
    this.element.removeClass(this.config.checkedClass);
    this.input.erase('checked');
    this.checked = false;
    this.fireEvent('uncheck', this);
  }
});


/*
---
name: Form.CheckGroup
description: Class to represent a group of Form.Check wrapped checkboxes
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event, Form-Replacement/Form.Check]
provides: Form.CheckGroup
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.CheckGroup = new Class({
  Implements: [Events,Options],
  options: {
    checkOptions: {},
    initialValues: {}
  },
  checks: [],
  initialize: function(group,options) {
    if (!Form.Check) { throw 'required Class Form.Check not found'; }
    this.setOptions(options);
    group = document.id(group);
    if (!group) { return this; }
    var checkboxes = group.getElements('input[type=checkbox]');
    checkboxes.each(this.addCheck,this);
  },
  addCheck: function(checkbox) {
    var initialValues = this.options.initialValues[checkbox.get('name')];
    var checkOptions = {};
    checkOptions.checked = initialValues ? initialValues.contains(checkbox.get('value')) : checkbox.get('checked');
    checkOptions.disabled = checkbox.get('disabled');
    checkbox.store('Form.CheckGroup::data',this);
    var check = checkbox.retrieve('Form.Check::data') || new Form.Check(checkbox, Object.append(checkOptions,this.options.checkOptions));
    this.checks.push(check);
  },
  checkAll: function() {
    this.checks.each(function(check) { if (!check.checked) { check.toggle(); } });
  },
  disable: function() {
    this.checks.each(function(check) { check.disable(); });
    this.fireEvent('disable',this);
  },
  enable: function() {
    this.checks.each(function(check) { check.enable(); });
    this.fireEvent('enable',this);
  },
  uncheckAll: function() {
    this.checks.each(function(check) { if (check.checked) { check.toggle(); } });
  }
});


/*
---
name: Form.Radio
description: Class to represent a radio button
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event, Form-Replacement/Form.Check]
provides: Form.Radio
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.Radio = new Class({
  Extends: Form.Check,
  config: {
    elementClass: 'radio',
    storage: 'Form.Radio::data'
  },
  initialize: function(input,options) {
    this.parent(input,options);
  },
  toggle: function(e) {
    if (this.element.hasClass('checked') || this.disabled) { return; }
    var evt;
    if (e) { evt = new Event(e).stop(); }
    if (this.checked) {
      this.uncheck();
    } else {
      this.check();
    }
    this.fireEvent(this.checked ? 'onCheck' : 'onUncheck',this);
    this.fireEvent('onChange',this);
  }
});

/*
---
name: Form.RadioGroup
description: Class to represent a group of Form.Radio buttons
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event, Form-Replacement/Form.Radio]
provides: Form.RadioGroup
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.RadioGroup = new Class({
  Implements: [Events,Options],
  options: {
    radioOptions: {},
    initialValues: {}
  },
  bound: {},
  radios: [],
  value: null,
  initialize: function(group,options) {
    if (!Form.Radio) { throw 'required Class Form.Radio not found'; }
    this.setOptions(options);
    this.bound = { select: this.select.bind(this) };
    group = document.id(group);
    if (!group) { return this; }
    var radios = group.getElements('input[type=radio]');
    radios.each(this.addCheck,this);
  },
  addCheck: function(radio,i) {
    var initialValues = this.options.initialValues[radio.get('name')];
    var radioOptions = {};
    radioOptions.checked = initialValues ? initialValues.contains(radio.get('value')) : radio.get('checked');
    radioOptions.disabled = radio.get('disabled');
    var check = (radio.retrieve('Form.Radio::data')
                 || new Form.Radio(radio,Object.append(radioOptions,this.options.radioOptions)));
    check.addEvent('onCheck',this.bound.select);
    if (check.checked) { i ? this.changed(check) : this.value = check.value; }
    radio.store('Form.RadioGroup::data',this);
    this.radios.push(check);
  },
  changed: function(radio) {
    this.value = radio.value;
    this.fireEvent('onChange',this);
  },
  disable: function() {
    this.radios.each(function(radio) { radio.disable(); });
  },
  enable: function() {
    this.radios.each(function(radio) { radio.enable(); });
  },
  select: function(checkedRadio) {
    this.radios.each(function(radio) {
      if (radio.checked && radio.value !== checkedRadio.value) { radio.uncheck(); }
    });
    if (checkedRadio.value !== this.value) { this.changed(checkedRadio); }
  }
});


/*
---
name: Form.SelectOption
description: Class to represent an option for Form.Dropdown
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event]
provides: Form.SelectOption
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.SelectOption = new Class({
  Implements: [Events, Options],
  options: {
    optionTag: 'li',
    selected: false
  },
  config: {
    highlightedClass: 'highlighted',
    optionClass: 'option',
    selectedClass: 'selected'
  },
  element: null,
  bound: {},
  option: null,
  selected: false,
  text: null,
  value: null,
  initialize: function(option, options) {
    this.setOptions(options);
    option = document.id(option);
    this.option = option;
    this.bound = {
      deselect: this.deselect.bind(this),
      highlight: this.highlight.bind(this),
      removeHighlight: this.removeHighlight.bind(this),
      select: this.select.bind(this)
    };
    this.text = option.get('text');
    this.value = option.get('value');
    this.element = new Element(this.options.optionTag, {
      'class': (option.get('class') + ' ' + this.config.optionClass).trim(),
      'html': option.get('html'),
      'events': {
        click: this.bound.select,
        mouseenter: this.bound.highlight,
        mouseleave: this.bound.removeHighlight
      }
    });
    this.element.store('Form.SelectOption::data', this);
    option.store('Form.SelectOption::data', this);
  },
  deselect: function(e) {
    this.fireEvent('onDeselect', [this, e]);
    this.element.removeClass(this.config.selectedClass).addEvent('click', this.bound.select);
    this.selected = false;
  },
  destroy: function() {
    this.element = null;
    this.bound = null;
    this.option = null;
  },
  disable: function() {
    this.element.removeEvents({
      mouseenter: this.bound.highlight,
      mouseleave: this.bound.removeHighlight
    });
    this.fireEvent('onDisable', this);
  },
  enable: function() {
    this.element.addEvents({
      mouseenter: this.bound.highlight,
      mouseleave: this.bound.removeHighlight
    });
    this.fireEvent('onEnable', this);
  },
  highlight: function(e) {
    this.fireEvent('onHighlight', [this, e]);
    this.element.addClass(this.config.highlightedClass);
    return this;
  },
  removeHighlight: function(e) {
    this.fireEvent('onRemoveHighlight', [this, e]);
    this.element.removeClass(this.config.highlightedClass);
    return this;
  },
  select: function(e) {
    this.fireEvent('onSelect', [this, e]);
    this.element.addClass(this.config.selectedClass).removeEvent('click', this.bound.select);
    this.selected = true;
  }
});


/*
---
name: Form.Dropdown
description: Class to represent a select input
authors: Bryan J Swift (@bryanjswift)
license: MIT-style license.
requires: [Core/Class.Extras, Core/Element, Core/Element.Event, Form-Replacement/Form.SelectOption]
provides: Form.Dropdown
...
*/
if (typeof window.Form === 'undefined') { window.Form = {}; }

Form.Dropdown = new Class({
  Implements: [Events,Options],
  options: {
    excludedValues: [],
    initialValue: null,
    mouseLeaveDelay: 350,
    selectOptions: {},
    typeDelay: 500
  },
  bound: {},
  dropdownOptions: [],
  element: null,
  events: {},
  highlighted: null,
  input: null,
  open: true,
  selected: null,
  selection: null,
  typed: { lastKey: null, value: null, timer: null, pressed: null, shortlist: [], startkey: null },
  value: null,
  initialize: function(select,options) {
    this.setOptions(options);
    select = $(select);
    this.bound = {
      collapse: this.collapse.bind(this),
      expand: this.expand.bind(this),
      focus: this.focus.bind(this),
      highlightOption: this.highlightOption.bind(this),
      keydown: this.keydown.bind(this),
      keypress: this.keypress.bind(this),
      mouseenterDropdown: this.mouseenterDropdown.bind(this),
      mouseleaveDropdown: this.mouseleaveDropdown.bind(this),
      mousemove: this.mousemove.bind(this),
      removeHighlightOption: this.removeHighlightOption.bind(this),
      select: this.select.bind(this),
      toggle: this.toggle.bind(this)
    };
    this.events = { mouseenter: this.bound.mouseenterDropdown, mouseleave: this.bound.mouseleaveDropdown };
    this.value = this.options.initialValue;
    this.initializeCreateElements(select);
    var optionElements = select.getElements('option');
    this.updateOptions(optionElements);
    this.element.replaces(select);
    document.addEvent('click', this.bound.collapse);
    var eventName = Browser.Engine.trident || Browser.Engine.webkit ? 'keydown' : 'keypress';
    var target = Browser.Engine.trident ? document.id(document.body) : window;
    target.addEvent('keydown',this.bound.keydown).addEvent(eventName,this.bound.keypress);
  },
  initializeCreateElements: function(select) {
    var id = select.get('id');
    var dropdown = new Element('div', {
      'class': (select.get('class') + ' select').trim(),
      'id': (id && id !== '') ? id + 'Dropdown' : ''
    });
    var menu = new Element('div', {'class': 'menu'});
    var list = new Element('div', {'class': 'list'});
    var options = new Element('ul', {'class': 'options'});
    dropdown.adopt(menu.adopt(list.adopt(options)));
    var dropdownSelection = new Element('div', {
      'class': 'selection',
      events: {click: this.bound.toggle}
    });
    var dropdownBackground = new Element('div', { 'class': 'dropdownBackground' });
    var selection = new Element('span', { 'class': 'selectionDisplay' });
    var input = new Element('input', {
      type:'text',
      id: id,
      name: select.get('name'),
      events: {
        focus: this.bound.focus
      }
    });
    dropdownSelection.adopt(dropdownBackground, selection, input);
    dropdown.adopt(dropdownSelection);
    this.element = dropdown;
    this.selection = selection;
    this.input = input;
    return options;
  },
  collapse: function(e) {
    this.open = false;
    this.element.removeClass('active').removeClass('dropdown-active');
    if (this.selected) { this.selected.removeHighlight(); }
    this.element.removeEvents(this.events);
    this.fireEvent('collapse', [this, e]);
  },
  deselect: function(option) {
    option.deselect();
  },
  destroy: function() {
    this.element = null;
    this.selection = null;
    this.input = null;
  },
  disable: function() {
    this.collapse();
    this.input.set('disabled', 'disabled').removeEvents({blur:this.bound.blur, focus:this.bound.focus});
    this.selection.getParent().removeEvent('click', this.bound.toggle);
    this.fireEvent('disable', this);
  },
  enable: function() {
    this.input.erase('disabled').addEvents({blur:this.bound.blur, focus:this.bound.focus});
    this.selection.getParent().addEvent('click', this.bound.toggle);
    this.fireEvent('enable', this);
  },
  expand: function(e) {
    clearTimeout(this.collapseInterval);
    var evt = e ? new Event(e).stop() : null;
    this.open = true;
    this.input.focus();
    this.element.addClass('active').addClass('dropdown-active');
    if (this.selected) { this.selected.highlight(); }
    this.element.addEvents(this.events);
    this.fireEvent('expand', [this, e]);
  },
  focus: function(e) {
    this.expand();
  },
  foundMatch: function(e) {
    var typed = this.typed;
    var shortlist = typed.shortlist;
    var value = typed.value;
    var i = 0;
    var optionsLength = shortlist.length;
    var excludedValues = this.options.excludedValues;
    var found = false;
    if (!optionsLength) { return; }
    var option;
    do {
      option = shortlist[i];
      if (option.text.toLowerCase().indexOf(value) === 0 && !excludedValues.contains(option.value)) {
        found = true;
        option.highlight(e);
        typed.pressed = i + 1;
        i = optionsLength;
      }
      i = i + 1;
    } while(i < optionsLength);
    return found;
  },
  highlightOption: function(option) {
    if (this.highlighted) { this.highlighted.removeHighlight(); }
    this.highlighted = option;
  },
  isOpen: function() {
    return this.open;
  },
  keydown: function(e) {
    if (!this.open) { return; }
    this.dropdownOptions.each(function(option) { option.disable(); });
    document.addEvent('mousemove', this.bound.mousemove);
  },
  keypress: function(e) {
    if (!this.open) { return; }
    var evt = new Event(e);
    var code = evt.code;
    var key = evt.key;
    var typed = this.typed;
    var match, i, options, option, optionsLength, found, first, excludedValues, shortlist;
    switch(code) {
      case 38: // up
      case 37: // left
        if (typed.pressed > 0) { typed.pressed = typed.pressed - 1; }
        if (!this.highlighted) { this.dropdownOptions.getLast().highlight(e); break; }
        match = this.highlighted.element.getPrevious();
        match = match ? match.retrieve('Form.SelectOption::data') : this.dropdownOptions.getLast();
        match.highlight(e);
        break;
      case 40: // down
      case 39: // right
        if (typed.shortlist.length > 0) { typed.pressed = typed.pressed + 1; }
        if (!this.highlighted) { this.dropdownOptions[0].highlight(e); break; }
        match = this.highlighted.element.getNext();
        match = match ? match.retrieve('Form.SelectOption::data') : this.dropdownOptions[0];
        match.highlight(e);
        break;
      case 13: // enter
        evt.stop();
      case 9: // tab - skips the stop event but selects the item
        this.highlighted.select();
        break;
      case 27: // esc
        evt.stop();
        this.toggle();
        break;
      case 32: // space
      default: // anything else
        if (!(code >= 48 && code <= 122 && (code <= 57 || (code >= 65 && code <= 90) || code >=97) || code === 32)) {
          break;
        }
        if (evt.control || evt.alt || evt.meta) { return; }
        // alphanumeric or space
        key = code === 32 ? ' ' : key;
        clearTimeout(typed.timer);
        options = this.dropdownOptions;
        optionsLength = options.length;
        excludedValues = this.options.excludedValues;
        if (typed.timer === null) { // timer is expired
          typed.shortlist = [];
          if (key === typed.lastKey || key === typed.startkey) { // get next
            typed.pressed = typed.pressed + 1;
            typed.value = key;
          } else { // get first
            typed = this.resetTyped();
            typed.value = key;
            typed.startkey = key;
            typed.pressed = 1;
          }
          typed.timer = this.resetTyped.delay(500, this);
        } else {
          if (key === typed.lastKey) { // check for match, if no match get next
            typed.value = typed.value + key;
            if (this.foundMatch(e)) { // got a match so break
              typed.timer = this.resetTyped.delay(500, this);
              break;
            } else { // no match fall through
              typed.shortlist = [];
              typed.value = key;
              typed.pressed = typed.pressed + 1;
              typed.timer = null;
            }
          } else { // reset timer, get first match, set pressed to found position
            typed.timer = this.resetTyped.delay(500, this);
            typed.value = typed.value + key;
            typed.startkey = typed.value.substring(0, 1);
            typed.lastKey = key;
            this.foundMatch(e);
            break;
          }
        }
        typed.lastKey = key;
        shortlist = typed.shortlist;
        i = 0;
        found = 0;
        do {
          option = options[i];
          if (option.text.toLowerCase().indexOf(key) === 0 && !excludedValues.contains(option.value)) {
            if (found === 0) { first = option; }
            found = found + 1;
            if (found === typed.pressed) { option.highlight(e); }
            shortlist.push(option);
          }
          i = i + 1;
        } while(i < optionsLength);
        if (typed.pressed > found) {
          first.highlight(e);
          typed.pressed = 1;
        }
        break;
    }
  },
  mouseenterDropdown: function() {
    clearTimeout(this.collapseInterval);
  },
  mouseleaveDropdown: function() {
    this.collapseInterval = this.options.mouseLeaveDelay ? this.collapse.delay(this.options.mouseLeaveDelay,this) : null;
  },
  mousemove: function() {
    this.dropdownOptions.each(function(option) { option.enable(); });
    document.removeEvent('mousemove', this.bound.mousemove);
  },
  removeHighlightOption: function(option) {
    this.highlighted = null;
  },
  reset: function() {
    if (this.options.initialValue) {
      this.dropdownOptions.each(function(o) {
        if (o.value === this.options.initialValue) { o.select(); }
      }, this);
    } else {
      this.dropdownOptions[0].select();
    }
  },
  resetTyped: function() {
    var typed = this.typed;
    typed.value = null;
    typed.timer = null;
    return typed;
  },
  select: function(option, e) {
    this.dropdownOptions.each(this.deselect);
    this.selection.set('html', option.element.get('html'));
    var oldValue = this.value;
    this.value = option.value;
    this.input.set('value', option.value);
    this.selected = option;
    this.fireEvent('select', [this, e]);
    if (oldValue !== this.value) { this.fireEvent('change', [this, e]); }
    this.collapse(e);
  },
  toggle: function(e) {
    if (this.open) { this.collapse(e); }
    else { this.expand(e); }
  },
  updateOptions: function(optionElements) {
    var optionsList = this.element.getElement('ul').empty(),
        dropdownOptions = this.dropdownOptions.empty(),
        selectOptions = this.options.selectOptions;
    optionElements.each(function(opt) {
      var option = new Form.SelectOption(opt, selectOptions);
      option.addEvents({
        'onHighlight':this.bound.highlightOption,
        'onRemoveHighlight':this.bound.removeHighlightOption,
        'onSelect':this.bound.select
      }).owner = this;
      if (option.value === this.options.initialValue || opt.get('selected')) { this.select(option); }
      dropdownOptions.push(option);
      optionsList.adopt(option.element);
    }, this);
    if (!this.selected && optionElements[0]) { optionElements[0].retrieve('Form.SelectOption::data').select(); }
  }
});

