 
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
 				 
 			 if(resp.success && resp.active_count > 0){

 			 	 $("li.srnotification .ncntr").text(resp.active_count);
 			 	  
 			 }else{
 			 	
 			 }
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }

 function listNotifications(){
 	$(".notificationbar").toggle();

 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "load" },
 		success: function(resp){
	 		if(resp.success && resp.msgs.length > 0){
	 			//console.log(resp.msgs)
	 			var htmld = '<i class="uparrow"></i>';
	 				htmld += '<ul class="alert alert-danger alert-dismissible csbar">';
			 		for(var i=0; i <resp.msgs.length; i++){
			 			htmld += '<li class="notalt'+resp.msgs[i].status+'">';
			 			htmld += resp.msgs[i].msg;	
			 			htmld += '<span class="ddif">';
			 			htmld += '<i class="fa fa-calendar"></i>';
			 			htmld += resp.msgs[i].ddif;
			 			htmld += ' ago</span>';
			 			htmld += '</li>';
			 		}
			 		htmld += '</ul>';

			 		$(".notificationbar").html(htmld);
			 		removeAllNotifications();
	 		}
 
 		},
 		dataType: "json",
 		error: function(){

 		}
 	});

 }

 function removeAllNotifications(){
 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "clear" },
 		success: function(resp){
 			 $("li.srnotification .ncntr").html("");
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }
 
 
 
 