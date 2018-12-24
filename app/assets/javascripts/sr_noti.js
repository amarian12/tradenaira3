 
 $(document).ready(function(){  

 	//if(typeof(gon.current_user) != "undefined"){
 		//if(typeof(gon.current_user.sn) != "undefined"){
 			  setInterval(function(){
 			 	//sRNotification();
 			 },3000)
 		//}
 	//}

 	if ($("li.srnotification")[0]) {
 		var titlemsg = "No new notification"
 		$("li.srnotification")
 	 	.attr("title",titlemsg)
 	 	.attr("alt",titlemsg);
 		 
 		$("li.srnotification").click(function(){

 			listNotifications();
 		})
 	}

 })


 function sRNotification(){
 	// if(!){
 	// 	return false;
 	// }

 	$.ajax({
 		url: "/pages/alerts",
 		type: "post",
 		data: { task: "load" },
 		success: function(resp){
 			if(resp.success && resp.active_count > 0){
 			 	var ss = resp.active_count > 0 ? "s" : "";
 			 	var titlemsg = resp.active_count+" new notification"+ss;
 			 	if($(".srnotification")[0]){
 			 		$("li.srnotification .ncntr").text(resp.active_count);
 			 	 	$("li.srnotification ").addClass("active")
 			 	 	.attr("title",titlemsg)
 			 	 	.attr("alt",titlemsg);
 			 	} 			 	  
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
	 				var link = "";
			 		for(var i=0; i <resp.msgs.length; i++){
			 			htmld += '<li class="notalt'+resp.msgs[i].status+'">';
			 			switch(resp.msgs[i].link_page){
			 				case "wallet":
			 					link = "/funds";
			 				break;
			 				case "accept_decline":
			 					link = "/money/accept_decline_money";
			 				default:
			 					link = "/money/accept_decline_money";
			 			}
			 			htmld += '<a href="'+link+'" class="mnkpage">';
			 			htmld += resp.msgs[i].msg;	
			 			htmld += '</a>';	
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
 			var titlemsg = "No new notification";
 			 $("li.srnotification .ncntr").html("");
 			 $("li.srnotification").removeClass("active")
 			 .attr("title",titlemsg)
 			 .attr("alt",titlemsg);
 		},
 		dataType: "json",
 		error: function(){

 		}
 	})
 }
 
 
 
 