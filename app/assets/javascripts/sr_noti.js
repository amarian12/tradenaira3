 
 $(document).ready(function(){  

 	//if(typeof(gon.current_user) != "undefined"){
 		//if(typeof(gon.current_user.sn) != "undefined"){
 				//sRNotification();
 			  setInterval(function(){
 			 	sRNotification();
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

 	setdTime();
 	loadSignupfromOnEscrowPage();
 })


 function sRNotification(){

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


 function setdTime(){
 	var app_cont = $(".sms_authh input[type=submit]");
 	var timeinput = $("input#google_auth_dtime");
 	var today = new Date();
 	var years = today.getFullYear();
 	var months = today.getMonth()+1;
 	var day = today.getDate();
 	var hours = today.getHours();
 	var minutes = today.getMinutes();
 	var seconds = today.getSeconds();
 	var tzone = today.getTimezoneOffset();
 	var dtime = years+"-"+months+"-"+day+" "+hours+":"+minutes+":"+seconds+" "+tzone ;
 	//"yyyy-mm-dd hh:ii:ss"
 	 
 	if(app_cont[0]){
 		app_cont.click(function(){
 			timeinput.val(today);
 			//timeinput.attr("type","text")
 			//return false;
 		})
 	}
 }

 function manage_escrow(id, action_for, $this) {
 	if(!confirm("Are you sure?")){
 		return false;
 	}
 	
 	$($this).attr("disabled",true)
 	.text("Please wait ...")
 	$.ajax({
 		url: "/money/escrow_manage",
 		type: "POST",
 		dataType: "json",
 		data: { id: id, request_for: action_for  },
 		success: function(resp){
 			console.log(resp);
 			$($this).hide();
 			if (resp.success) {
 				$("#success-"+id).text(resp.msg);

 				if(action_for == "decline"){
 					$("#card-iteam-"+id+" a.accept").hide();
 				}else{
 					$("#card-iteam-"+id+" a.decline").hide();
 				}
 				
 			}else{
 				if(resp.errors.length > 0){
 					var er = "<p>"+resp.msg+"</p>";
 					for(var i=0; i < resp.errors.length; i++){
 						error = resp.errors[i];
 						er += '<p>'+error+'</p>';
 					}
 					$("#errors-"+id).html(er);

 				}
 			}
 		}

 	})
 	return false;
 }

function loadSignupfromOnEscrowPage(){ 


  // ***********signup**************// 
  var loginp = $(".signup_on_samepage");
  if(loginp[0]){
    var formc = $("#signupModal form").submit(function(){
    	$("#signupModal .signupErrmsges").html("");

    	var fdata = $(this).serializeArray();
    	var username,email,password,password_confirmationm,error,success;
    	var duser = { username: "", email: "", password: "" };
    	error = "";
    	for(var i=0; i<fdata.length; i++){
    		var itm = fdata[i];
    		if (itm.name == "email") {
    			email = itm.value;
    			duser.email = email;
    		}
    		if (itm.name == "password") {
    			password = itm.value;
    			duser.password = password;
    		}
    		if (itm.name == "password_confirmation") {
    			password_confirmation = itm.value;
    		}   		 
    	}

    	if (password == "" || password_confirmation == "") {
    		error += '<p class="error">Password or confirm password can not be blank!</p>';
    	}

    	if(password != password_confirmation ){
    		error += '<p class="error">Password and confirm password must be same!</p>';
    	}

    	if (error != "") {
    		$("#signupModal .signupErrmsges").html(error);
    		return false;
    	}
    	 
    	var furl = "/api/users";
    	$.ajax({
    		url: furl,
    		data: { user: duser },
    		type: 'post',
    		dataType: "json",
    		success: function(resp){
    			 if(typeof(resp.id) !="undefined"){
    			 	success = '<p class="success">Account created successfully.</p>';
    			 	$("#signupModal .signupSuccmsges").html(success);
    			 }
    			 setTimeout(function(){
    			 	//$('#signupModal').modal('toggle');
    			 	window.location = "";
    			 },1000);
    		},
    		error: function(resp){
    			for(var i=0; i<resp.responseJSON.length; i++){
					itm = resp.responseJSON[i];
					error += '<p class="error">'+itm+'</p>';
    			}
    			if(error!=""){
    				$("#signupModal .signupErrmsges").html(error);
    			}
    		}
    	})

       
      return false;
    })
  }

  // ***********Login**************// 
  var loginp = $(".login_on_samepage");
  if(loginp[0]){
    var formc = $("#loginModal form").submit(function(){
    	$("#loginModal .signupErrmsges").html("");

    	var fdata = $(this).serializeArray();
    	var sdata = $(this).serialize();
    	var faction = $(this).attr("action");

    	var username,email,password,error,success;
    	var duser = { username: "", email: "", password: "" };
    	error = "";
    	for(var i=0; i<fdata.length; i++){
    		var itm = fdata[i];
    		if (itm.name == "auth_key") {
    			email = itm.value;
    			duser.username = email;
    			duser.email = email;
    		}
    		if (itm.name == "password") {
    			password = itm.value;
    			duser.password = password;
    		}	 
    	}

     

    	if (password == "") {
    		error += '<p class="error">Password can not be blank!</p>';
    	}


    	if (error != "") {
    		$("#loginModal .signupErrmsges").html(error);
    		return false;
    	}
    	 
    	//var furl = "/api/session";
    	$.ajax({
    		url: faction,
    		data: sdata ,
    		type: 'post',
    		dataType: "json",
    		success: function(resp){
    			 if(typeof(resp.current_user) !="undefined"){
    			 	success = '<p class="success">Login success!.</p>';
    			 	$("#loginModal .signupSuccmsges").html(success);
    			 }
    			 setTimeout(function(){
    			 	//$('#signupModal').modal('toggle');
    			 	window.location = "";
    			 },1000);
    		},
    		error: function(resp){
    			error += '<p class="error">Invalid email or password!</p>';
    			if(error!=""){
    				$("#loginModal .signupErrmsges").html(error);
    			}
    		}
    	})

       
      return false;
    })
  }
}
 
 
 
 