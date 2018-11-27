 var msgresp = "";
 $(document).ready(function(){ 

 	if(typeof(gon.current_user) != "undefined"){
 		if(typeof(gon.current_user.sn) != "undefined"){
 			  setInterval(function(){
 			 	sRNotification();
 			 },3000)
 		}
 	}

 	if ($("li.srnotification")[0]) {
 		 
 		$("li.srnotification").click(function(){

 			listNotifications();
 		})
 	}

 })


 function sRNotification(){
 	if(!$(".srnotification")[0]){
 		return false;
 	}

 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "load" },
 		success: function(resp){
 				 
 			 if(resp.success && resp.msgs.length > 0){

 			 	var noti = '<i class="fa fa-bell" aria-hidden="true"></i>';
 			 	noti += '<span class="ncntr">'+resp.msgs.length+'</span>';
 			 	 $("li.srnotification").html(noti);
 			 	 msgresp = resp.msgs;

 			 	 // .click(function(){
 			 	 // 	listNotifications(resp);
 			 	 // })
 			 }else{
 			 	
 			 }
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }

 function listNotifications(){
 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "load" },
 		success: function(resp){
	 		if(resp.success && resp.msgs.length > 0){
	 			var htmld = '<ul class="alert alert-danger alert-dismissible csbar">';
			 		for(var i=0; i <resp.msgs.length; i++){
			 			htmld += '<li>'+resp.msgs[i].msg+'</li>';	
			 		}
			 		htmld += '</ul>';

			 		$(".notificationbar").html(htmld)
			 		.toggle();
			 		removeAllNotifications();
	 		}
 
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }

 function removeAllNotifications(){
 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "clear" },
 		success: function(resp){
 			 $("li.srnotification").html("");
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }
 
 
 
 