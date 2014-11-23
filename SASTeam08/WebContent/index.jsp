<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/jquery.jscrollpane.css"/>
<script src="javascripts/jquery.js"></script>
<script src="javascripts/jquery-color.js"></script>
<script type="text/javascript" src="./script/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="./script/jquery.mousewheel.js"></script>
<script type="text/javascript" src="./script/mwheelIntent.js"></script>
<script type="text/javascript" src="./script/jquery.jscrollpane.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SAS Campaign Manager</title>
</head>
<body>
<div class="header">
	<!-- <button class="menu_btn"></button> -->
	<button class="header_btn" id="group"></button>
	<button class="header_btn" id="user"></button>
	<button class="header_btn" id="help"></button>
	<button class="header_btn" id="alert"></button>
	<button class="header_btn" id="search"></button>
</div>
<!--<div class="navBar" id="campaign1">
	<img class="back_arrow"  src="images/back_arrow.png"/>
	<div class="navBarText">2014 Christmas - Canned Food Drive</div>
</div>-->

<!-- side bar on the left side of screen -->
<div class="dashboard" id="dashboard">
	<img class="logo" src="images/Icon-01.png"/>
	<img class="hbar" src="images/horizontal_bar.png"/>
	<div class="dashboard_link">Dashboard</div>
	<div class="dashboard_link">Campaign <br/> Builder</div>
	<br/>
	<div class="dashboard_link">Analytics</div>
	<div class="dashboard_link">Media <br/> Manager</div>
	<br/>
	<div class="dashboard_link">Calendar</div>
	<div class="dashboard_link">Email</div>
	<img class="sas_db_logo" src="images/sas_db_logo.png">
</div>
<div class="activeItem" id="activeItem">
  <div class="accordion-toggle">
    <div class="accordion-header">
   	  <img class="back_arrow"  src="images/back_arrow.png"/>
  	  2014 Christmas - Canned Food Drive
    </div>
  </div>
</div>

<div class="accordion" id="dock">
  <div class="accordion-toggle">
  <div class="accordion-header">
  	<img class="back_arrow"  src="images/back_arrow.png"/>
  	Creative Thanksgiving
  </div>
  </div>
  <div class="accordion-toggle">
  <div class="accordion-header">
  	<img class="back_arrow"  src="images/back_arrow.png"/>
  	Fall, All Things Pumpkin</div>
  </div>
  <div class="accordion-toggle">
  <div class="accordion-header">
	  <img class="back_arrow"  src="images/back_arrow.png"/>
	  End of Summer BBQ</div>
  </div>
</div>

<div class="documentDisplay">
	<div class="documentDisplayTable"> 
		<div class="documentRow">
			<div class="documentBox"></div>
			<div class="documentBox"></div>
			<div class="documentBox"></div>
		</div>
	</div>
	<div class="documentDisplayTable"> 
		<div class="documentRow">
			<div class="documentBox"></div>
			<div class="documentBox"></div>
			<div class="documentBox"></div>
		</div>
	</div>
	<div class="documentDisplayTable"> 
		<div class="documentRow">
			<div class="documentBox"></div>
			<div class="documentBox"></div>
			<div class="documentBox"></div>
		</div>
	</div>
</div>

<div class="chat">
	<div class="chatsReceived" id="chatsReceived">
		<div class="chatItem">
			<img class="chatBubbleAvatar" src="images/chatAvatar.png">
			<div class="chatBubble">This is a chat bubble</div>
		</div>
	</div>
	<textarea class="chatInput"></textarea>
</div>

<div class="chatBar" id="chatBar"></div>
</body>
<script>
	var showingDashboard = true; 
	$('.accordion-toggle').click(function () {
		if (!$(this).hasClass("navBar")) { //when an item is clicked and is not top item
			var goingActive = $(this);
			var lastActive = $('#activeItem > .accordion-toggle');
			goingActive.animate({marginLeft:"200%"}, 300);
			$('#activeItem').animate({top:"-20px"}, 300, function () {
				$('.accordion-toggle').not(goingActive).css({backgroundColor:"#0D7D7B"}); //change all other bgs to dark green
				$(goingActive).addClass("navBar", true);
				$('#activeItem').css({top:"45px"});
				lastActive.css({borderBottom:"1px solid white", marginLeft: "200%"});
				lastActive.appendTo("#dock"); // prepend activeItem to dock
				lastActive.animate({marginLeft:"0"}, 300);
				goingActive.prependTo('#activeItem');
				goingActive.animate({marginLeft:"0"}, 300);
				$('.accordion-toggle').not(goingActive).removeClass("navBar"); // remove navBar class from all other items
				$(goingActive).animate({backgroundColor:"#8cb755"}, 300); //change bg to light green
				$(goingActive).css({borderBottom:"0px"});
			});
		} else { //when an item is clicked and is top item
			//clicking on a campaign header should hide the dashboard
			if (showingDashboard === true) {
				$('.dashboard').animate({left:-175}, 300); //hide the dashboard
				$(this).find('.accordion-header').animate({marginLeft:"15px"}, 300); //move text left
				$(this).find('.accordion-header > .back_arrow').animate({opacity:1}, 1000); // show back arrow
				$(".accordion-toggle").not($(this)).animate({opacity:0}); //hide all other accordion-toggle classes
				$(".documentDisplay").animate({left:"40px", bottom:"5px", top:"200px"}, 300);
				$(".chatsReceived").empty();
				$(".chat").animate({right: "20px"});
				
				showingDashboard = false; 
			//clicking again should show the dashboard
			} else {
				$('.dashboard').animate({left:0}, 300);
				$(this).find('.accordion-header').animate({marginLeft:"200px"}, 300);
				$(this).find('.accordion-header > .back_arrow').animate({opacity:0}, 300);
				$(".accordion-toggle").not($(this)).animate({opacity:1});
				$(".documentDisplay").animate({left:"180px", bottom:"138px", top:"90px"}, 300);
				$(".chat").animate({right: "-200px"});
				showingDashboard = true;
			}
		}
	});
	
	
	// handle chat functionality
	$(".chatInput").on("keyup", function (e) {
		var code = (e.keycode) ? e.keycode : e.which; 
		if (code === 13) {
			var chatItem = "<div class=\"chatItem\">";
			var img = "<img class=\"chatBubbleAvatar\" src=\"images/chatAvatar.png\"/>";
			var submit = "<div class=\"chatBubble\">" + $('.chatInput').val() + "</div></div>";
			$(chatItem + img + submit).appendTo($('.chatsReceived'));
			updateChatScroller();
			$('.chatInput').val("");
		}
	});
	
	
	$(document).ready(function($) {
		$(".activeItem > .accordion-toggle").css({backgroundColor:"#8cb755", borderBottom:0});
		$(".activeItem > .accordion-toggle").addClass("navBar");
		
		/*$('#dock').find('.accordion-toggle').click(function(){
			
			    //Expand or collapse this panel
			$(this).next().slideToggle('fast');
			
			    //Hide the other panels
			$('.accordion-content').not($(this).next()).slideUp('fast');
		});*/
	});
	
	function updateChatScroller () {
		var element = document.getElementById("chatsReceived");
		element.scrollTop = element.scrollHeight;
	}
	
	
	// Use the function below to add a scroll bar to a div
// 	$(function() {
// 		$('.dashboard').jScrollPane();
// 	});
</script>
</html>
