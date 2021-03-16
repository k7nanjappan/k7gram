// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


//= require jquery3

//= require rails-ujs
//= require activestorage

//= require dropzone
//= require_tree .
//= require toastr


//import Rails from "@rails/ujs"
//import Turbolinks from "turbolinks"
//import * as ActiveStorage from "@rails/activestorage"
//import "channels"


import "bootstrap";

import "../stylesheets/application";
import Dropzone from "dropzone";
require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

//require("packs/custom")
//require("packs/posts.js")
//require("dropzone").start()
import './src/application.scss';
import toastr from 'toastr/toastr';
window.toastr = toastr
//global.toastr = require("toastr")




// Dropzone code


Dropzone.autoDiscover = false;

$("#upload").ready(function() {
	$(".upload-images").dropzone( {
		addRemoveLinks: true,
		maxFilesize: 1,
		autoProcessQueue: false,
		uploadMultiple: true,
		parallelUploads: 100,
		maxFiles: 100,
		paramName: "images",
		previewsContainer: ".dropzone-previews",
		clickable: ".upload-photos-icon",
		thumbnailWidth: 100,
		thumbnailHeight: 100,

		init: function() {
			var myDropzone = this;


			this.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
				e.preventDefault();
				e.stopPropagation();
				myDropzone.processQueue();
			});

			this.on("successmultiple", function(files, response) {
				window.location.reload();
			});

			this.on("errormultiple", function(files, response) {
				toastr.error(response);
			});
		}
	})
});

$(document).ready(function(){
$("#users-search #term").on("keyup", function() { // keyup selects the users-search and the event is called whenever user starts typing!
	var jqxhr = $.get(
		// "action" is the link to our form in the controller. In our case, action: "/users"
		// {term: ...} is like a json data
		// .val gives the value in the text-box (our search query)
		$("#users-search").attr("action"),
		{term: $("#users-search #term").val()},
		function() {
			var result = $("#users-result").html();
			if(!result) {
				$("#users-search #term").popover({
					content: "No result found.",
					placement: "bottom",
					html: true,
					trigger: "focus"
				});
			} else {
				$("#users-search #term").popover({
					content: $("#users-result"),
					placement: "bottom",
					html: true,
					trigger: "focus"
				});
			}
			// now after checking the search result and putting it's value in popover, we call it by "show" method
			$("#users-search #term").popover("show");
		  }
		)
    })
});





//Rails.start()
//Turbolinks.start()
//ActiveStorage.start()
