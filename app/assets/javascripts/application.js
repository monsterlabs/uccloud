// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require html5shiv
//= require jquery.maskedinput
//= require_tree .


var videos = 1;

	var publisher;
	var publisherObj;

	var subscribers = {};
	var subscriberObj = {};

	var MAX_WIDTH_VIDEO = 264;
	var MAX_HEIGHT_VIDEO = 198;

	var MIN_WIDTH_VIDEO = 200;
	var MIN_HEIGHT_VIDEO = 150;

	var MAX_WIDTH_BOX = 800;
	var MAX_HEIGHT_BOX = 600;

	var CURRENT_WIDTH = MAX_WIDTH_VIDEO;
	var CURRENT_HEIGHT = MAX_HEIGHT_VIDEO;

	function sessionConnectedHandler(event) {
		publish();

		for (var i = 0; i < event.streams.length; i++) {
      var stream = event.streams[i];
      addStream(stream);
      var data = $.parseJSON(stream.connection.data);

      $('#users').append('<div class="user">' + data.email + '</div>');
		}
	}

	function streamCreatedHandler(event) {
		for (var i = 0; i < event.streams.length; i++) {

      var stream = event.streams[i];
      addStream(stream);
      var data = $.parseJSON(stream.connection.data);

      $('#users').append('<div class="user">' + data.email + '</div>');
		}
	}

	function streamDestroyedHandler(event) {
		videos--;
    $('#users .user').each(function (user) {

    });
		layoutManager();
	}


	function exceptionHandler(event) {
    	alert("Exception msg:" + event.message + "title: " + event.title + " code: " + event.code);
	}

	//--------------------------------------
	//  HELPER METHODS
	//--------------------------------------
	function addStream(stream) {
		// Check if this is the stream that I am publishing. If not
		// we choose to subscribe to the stream.
		if (stream.connection.connectionId == session.connection.connectionId) {
			return;
		}

		var div = document.createElement('div');	// Create a replacement div for the subscriber
		var divId = stream.streamId;	// Give the replacement div the id of the stream as its id
		div.setAttribute('id', divId);
		document.getElementById("videobox").appendChild(div);
		subscriberObj[stream.streamId] = div;
		subscribers[stream.streamId] = session.subscribe(stream, divId, {"width": CURRENT_WIDTH, "height": CURRENT_HEIGHT});

		videos++;
		layoutManager();
	}

	function publish() {
		if (!publisher) {
			var parentDiv = document.getElementById("videobox");
			publisherObj = document.createElement('div');			// Create a replacement div for the publisher
			publisherObj.setAttribute('id', 'opentok_publisher');
			parentDiv.appendChild(publisherObj);
			publisher = session.publish('opentok_publisher', {"width": CURRENT_WIDTH, "height": CURRENT_HEIGHT});
		}
	}

	function layoutManager() {
		var estBoxWidth = MAX_WIDTH_BOX / videos;
		var width = Math.min(MAX_WIDTH_VIDEO, Math.max(MIN_WIDTH_VIDEO, estBoxWidth));
		var height = 3*width/4;

		publisherObj.height = height;
		publisherObj.width = width;

		for(var subscriberDiv in subscriberObj) {
			subscriberDiv.height = height;
			subscriberDiv.width = width;
		}

		CURRENT_HEIGHT = height;

		CURRENT_WIDTH = width;
	}