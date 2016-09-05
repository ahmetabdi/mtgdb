// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).on('ready page:load', function(event) {
	Handlebars.registerHelper('toLowerCase', function(str) {
	  return str.toLowerCase();
	});

	Handlebars.registerHelper('toSymbols', function(str) {
    if (str) {
      var all_numbers = str.match(/\d+/g)

      $(all_numbers).each(function(index, value) {
        var regex = new RegExp("\\{"+value+"\\}", "g");
        str = str.replace(regex, '<i class="mi mi-mana mi-shadow mi-'+value+'"></i>\n');
      });

      var all_characters = str.match(/[a-zA-Z]+/g)

      $(all_characters).each(function(index, value) {
        var regex = new RegExp("\\{"+value+"\\}", "g");
        str = str.replace(regex, '<i class="mi mi-'+value.toLowerCase()+' mi-mana mi-shadow"></i>\n');
      });
    }

		return str;
	});

	Handlebars.registerHelper('compare', function (lvalue, operator, rvalue, options) {
    var operators, result;

    if (arguments.length < 3) {
        throw new Error("Handlerbars Helper 'compare' needs 2 parameters");
    }

    if (options === undefined) {
        options = rvalue;
        rvalue = operator;
        operator = "===";
    }

    operators = {
        '==': function (l, r) { return l == r; },
        '===': function (l, r) { return l === r; },
        '!=': function (l, r) { return l != r; },
        '!==': function (l, r) { return l !== r; },
        '<': function (l, r) { return l < r; },
        '>': function (l, r) { return l > r; },
        '<=': function (l, r) { return l <= r; },
        '>=': function (l, r) { return l >= r; },
        'typeof': function (l, r) { return typeof l == r; }
    };

    if (!operators[operator]) {
        throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator);
    }

    result = operators[operator](lvalue, rvalue);

    if (result) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }
	});

	if ($('#demo-input').length) {
		var bloodQuery = new Bloodhound({
		  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
		  queryTokenizer: Bloodhound.tokenizers.whitespace,
		  remote: {
		    url: "/search?query=%QUERY",
		    wildcard: '%QUERY'
		  }
		});

		$('#demo-input').typeahead({
		  hint: $('.Typeahead-hint'),
		  menu: $('.Typeahead-menu'),
		  minLength: 1,
		  // highlight: true,
		  classNames: {
		    open: 'is-open',
		    empty: 'is-empty',
		    cursor: 'is-active',
		    suggestion: 'Typeahead-suggestion',
		    selectable: 'Typeahead-selectable'
		  }
		}, {
		  name: 'best-pictures',
		  displayKey: 'name',
		  source: bloodQuery,
      limit: 20,
		  //source: function(query, syncResults, asyncResults) {
      //  console.log(query);
      //  $.get('/search?query=' + encodeURIComponent(query), function(data) {
      //    asyncResults(data);
      //  });
			//},
		  templates: {
		    suggestion: Handlebars.compile($("#result-template").html()),
		    empty: Handlebars.compile($("#empty-template").html())
		  }
		})
		.on('typeahead:asyncrequest', function() {
		  $('.Typeahead-spinner').show();
		})
		.on('typeahead:asynccancel typeahead:asyncreceive', function() {
		  $('.Typeahead-spinner').hide();
		})
		.on('typeahead:select', function(object, suggestion) {
			if (suggestion._type == 'magic_card') {
				window.location.href = "/cards/" + suggestion.slug;
			}
			else if (suggestion._type == 'magic_set') {
				window.location.href = "/sets/" + suggestion.slug;
			}
		})
		.on('typeahead:autocomplete', function(object, suggestion) {
		  if (suggestion._type == 'magic_card') {
				window.location.href = "/cards/" + suggestion.slug;
			}
			else if (suggestion._type == 'magic_set') {
				window.location.href = "/sets/" + suggestion.slug;
			}
		});
	}
});

$(function(){ $(document).foundation(); });
