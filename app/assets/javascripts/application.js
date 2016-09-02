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
//= require turbolinks
//= require_tree .

$.fn.spectrum=function(arrayOfColors){
  return this.each(function(){
    var self=$(this);
    (function spectrum(){
      var hue=arrayOfColors.shift()
      arrayOfColors.push(hue)
      self.animate({ borderColor: hue }, 1000,spectrum)
    })();
  })
}

$(document).on('ready page:load', function(event) {
  if ($('.Typeahead').length) {
    $('.Typeahead').spectrum(["#8A2BE2", "#4E0096"])
  }

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
		  minLength: 0,
		  highlight: true,
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
		});
		// .on('typeahead:select', function(object, suggestion) { // Call when clicking on a suggestion
		//   window.location.href = "/movies/" + suggestion.slug;
		// })
		// .on('typeahead:autocomplete', function(object, suggestion) {
		//   window.location.href = "/movies/" + suggestion.slug;
		// });
	}
});