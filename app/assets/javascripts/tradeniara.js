$(document).ready(function() {
		$(".form-group>.form-submit").removeClass("col-xs-22").addClass("col-md-16 col-sm-18 col-xs-24");
		$(".two-factor-auth-container + .form-group>.form-submit").removeClass("col-md-16 col-sm-18 col-xs-24").addClass("col-xs-18");
		$(".ticket .col-xs-14").addClass("col-md-8 col-sm-10 col-xs-16");
        // Tooltip only Text
        $('.masterTooltip').hover(function(){
                // Hover over code
                var title = $(this).attr('title');
                $(this).data('tipText', title).removeAttr('title');
                $('<p class="tooltip"></p>')
                .text(title)
                .appendTo('body')
                .fadeIn('slow');
        }, function() {
                // Hover out code
                $(this).attr('title', $(this).data('tipText'));
                $('.tooltip').remove();
        }).mousemove(function(e) {
                var mousex = e.pageX + 20; //Get X coordinates
                var mousey = e.pageY + 10; //Get Y coordinates
                $('.tooltip')
                .css({ top: mousey, left: mousex });
        });

 

	$(window).scroll(function(){
    var sticky = $('.site-main-header');

		if($(window).scrollTop() > 100){

      sticky.addClass('fixed-header');
			//$(".home_head>li>a>i").hide();
			// $(".home_head>li>a>i").addClass("home_icon1").removeClass("home_icon");
			// $(".home_head>li>a").addClass("margin_top1");
			// $(".tophead>li").addClass("margin_top1");
			// $(".tophead>li>a>i").addClass("home_icon1").removeClass("home_icon");
			// $(".home_logo").addClass("home_logo1").removeClass("home_logo");
			// $(".home_signup").addClass("home_signup1").removeClass("home_signup");
		}
		if($(window).scrollTop() < 100){
       sticky.removeClass('fixed-header');
			//$(".home_head>li>a>i").show();
			// $(".home_head>li>a>i").addClass("home_icon").removeClass("home_icon1");
			// $(".home_head>li>a").removeClass("margin_top1");
			// $(".tophead>li").removeClass("margin_top1");
			// $(".tophead>li>a>i").addClass("home_icon").removeClass("home_icon1");
			// $(".home_logo1").addClass("home_logo").removeClass("home_logo1");
			// $(".home_signup1").addClass("home_signup").removeClass("home_signup1");
		}
		});   
});

//Live Price exchange is update from BTCC site
 
  var BASEURL = '';
  var PASSPORTURL = 'https://www.btcchina.com';
  var DATAURL = 'https://data.btcchina.com/data';
  var CDNURL = 'https://com.btcchinacdn.com/';
  var locale = 'en';
  var controller = 'index';
  var action = 'index.new';
  var LANG_PRICE = 'Price: ';
  var CAPS_LOCK = 'Caps Lock is On';
  var g_IsSandbox = false;
  var g_IsBtcxo = false;
  var LOGGED_IN = '';
  var WEBSOCKETURL = 'https://websocket.btcchina.com';
  var NAV_HASH = 'MTVjNzc2ZTI3Y2Y1ODhlYzA2OGJmYjIzZTIyN2Y3ZTU=';
  var userAgent = window.navigator.userAgent.toLowerCase(),
      safari = /safari/.test( userAgent ),
      ios = /iphone|ipad|ipod/.test( userAgent ),
      windows = navigator.userAgent.match(/windows/i);
  if(windows) {
    if (document.body) {
      document.body.className += " windows";
    }
	  
  }
  if (ios && safari) {
    try { localStorage.test = 2; } catch (e) {
      alert('Sorry, you are in the private mode, To improve your experience, places exit private mode.');
    }
  }
  $(document).ready(function() {
  	$('.navbar-toggle').on('click', function(){
  		$('.navbar-collapse').toggle(1000);
  	});
  	 
  	 
  	 $(".gbpngn").mousedown(function(e) 
  	 {
      var url= $(this).attr('data-link');
      var head= $(this).attr('head');
      var cls = '.last-'+$(this).attr('datas')+'-live-ticker';
      var ask = '.last-'+$(this).attr('datas')+'-ask';
      var bid = '.last-'+$(this).attr('datas')+'-bid';
      var low = '#low_'+$(this).attr('datas');
      var high= '#high_'+$(this).attr('datas');
      var ask_rate= '0.0';
      var bids_rate= '0.0';
      var price ='0.0';
       $.ajax({
          type: 'GET',
          dataType: "json",
          url: url,
          dataType: "json",
          success:function(data){
           if(data.trades[0])
             price = data.trades[0]['price'];
           if(data.asks[0])
            ask_rate=data.asks[0][0];
           if(data.bids[0])
            bids_rate=data.bids[0][0];

          //alert(JSON.stringify(data))
          
          var index = 0;

          var val_high = val_low = data.trades[0]['price'];

          

          for (var i = 1; i < data.trades.length; i++) {
            if (data.trades[i]['price'] > val_high) {
              var val_high = data.trades[i]['price'];
              index = i;
            }
            if (data.trades[i]['price'] < val_low) {
              var val_low = data.trades[i]['price'];
              index = i;
            }
          }
           


          $(cls).text(' '+price.toString());
          $(ask).text(' '+ask_rate.toString());
          $(bid).text(' '+bids_rate.toString());
          $(high).text(' '+val_high.toString());
          $(low).text(' '+val_low.toString());
          $('.last_volume').text(data.trades[0]['amount']+' '+head);
          },
          error:function(data){
          alert("Error");
          }
          });

       
  	 	// setTimeout(function(){location.reload()}, 1000);
  	 })
  	 $(".lnk").click(function () 
  	 {
        var url = $(this).attr('data-link');
        $("#frameExternal").attr('src', url);
     });
       
  });

$(function() {
	$(".nav-pills li").click(function(){
	  var href = $(this).find('a').attr('data-link');
    var datas = $(this).find('a').attr('datas');

    //alert("ul#ticker-"+datas);

    $(".home-trad-list ul").addClass("ng-hide");
    $(".home-trad-list ul#ticker-"+datas).removeClass("ng-hide");

      if (typeof($.session) == "undefined") {
        return false;
      }
      $.session.set("myVar", href);
      $(".nav-pills li").removeClass("active");
      $(this).addClass("active");
      return false;
  })
});

// To Read
$(function() {
    //alert($.session.get("myVar"));
	url  = document.location.origin ;

	root  = window.location.href;
	if ($("#market_list")[0] && typeof($.session) != "undefined")
	{ //alert(1)
    if($.session.get("myVar") == '/markets/usdngn')
    { 
    	$("#li1").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/gbpngn')
    {
    	$("#li2").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/eurngn')
    {
    	$("#li3").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/cnyngn')
    {
    	$("#li4").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/btcngn')
    {
      $("#li5").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/btcusd')
    {
      $("#li6").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/btcgbp')
    {
      $("#li7").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/btceur')
    {
      $("#li8").addClass("active");
    }
    else if($.session.get("myVar") == '/markets/btccny')
    {
      $("#li9").addClass("active");
    }
    else
    {
    	$("#li1").addClass("active");
    }
   }else{
    $("#li1").addClass("active");
   }

var marketp = $("#li1 a");
if (marketp[0]) {
  $("#li1 a.gbpngn").trigger("mousedown")
  

    // var datalink = marketp.data("link");
    // $.ajax({
    //   url: datalink,
    //   type: "get",
    //   dataType: "json",
    //   success: function(resp){
    //     //alert(JSON.stringify(resp))
    //   }
    // })
}
  $(function() {
    var completer;

    if(typeof(GmapsCompleter) != "undefined"){
        completer = new GmapsCompleter({
        inputField: '#gmaps-input-address',
        errorField: '#gmaps-error'
      });

      completer.autoCompleteInit({
        country: "us"
      });

    }
    
  });

  showFloatingPoints();
  showVidoFroncontent();
  showCurrencyPrice();

});


function submitEnquirey($this){
  var turl = $($this).attr("action");
  var tdata = $($this).serialize();

  $("#submitformbtn").attr("disabled",true)
  .val("Submitting...");


  $.ajax({
    url: turl,
    type: "POST",
    data: tdata,
    dataType: "json",
    success: function(resp){
      if(resp.success){
        var msg = "<p class='successmsg'>Thanks for connecting with us, we will back to you shortly!</p>";
        $(".moformcontainer").html(msg);
      }else{
        var error_html = "<ul class='error-msgs'>";

        for(var error in resp.errors){
          if (resp.errors.hasOwnProperty(error)) {

            error_html += "<li>"+error.replace("_", " ").toLowerCase()+": "+resp.errors[error]+"</li>";
             //alert("Key is " + error + ", value is" + resp.errors);
          }
        }

        error_html += "</ul>";

        $("#respErrmsges").html(error_html);

        $("#submitformbtn").removeAttr("disabled")
        .val("Submit");

      }
    },
    error:function(errors){
      //alert(JSON.stringify(errors))
    }
  });

  return false;
}


function showFloatingPoints(){

    animatePointer();
  

    setInterval(function() {
      
        animatePointer();
         
    }, 4000);

}


function animatePointer(){
      var nairas = "<i class='flaticon-nigeria-naira-currency-symbol'></i>";
      var contain = $(".dfloatmap");
      var pointsa = [
      { price1: "$5,000",      price2: "$191"},
      { price1: "£3,000",      price2: "£138"},
      { price1: "$12,000",     price2: "$245"},
      { price1: nairas+"600,000",    price2: nairas+"15,360 "},
      { price1: nairas+"750,000",    price2: nairas+"19,750"},
      { price1: "GH₵14,000",     price2: "GH₵720"},
      { price1: "$28,000",     price2: "$495"},
      { price1: nairas+"800,000",    price2: nairas+"17,120 "},
      { price1: nairas+"1,350,000",  price2: nairas+"28,960"},
      { price1: "$8,000",      price2: "$377"},
      { price1: "€6,000",      price2: "€320"},
      { price1: "$13,500",     price2: "$548"},
      { price1: nairas+"500,000 ",   price2: nairas+"14,500 "},
      { price1: "€3,000",      price2: "€180"},
      { price1: "£7,500",      price2: "£344"},
      { price1: "$7,000",      price2: "$314"},
      { price1: nairas+"250,000 ",   price2: nairas+"9,120"}
      ];
  if(contain[0]){
      var dblpr = parseInt(Math.random()*16);
      var cpoint = pointsa[dblpr];
      var dbble1 = cpoint.price1;
      var dbble2 = cpoint.price2;
      var dbspn1 = dbble1+" Moments AGO";
      var dbspn2 = dbble2+" SAVED";

       

     var dbubble = "<div class='dbble-cont dbbble-point-id-"+dblpr+"'>";

           dbubble += "<div class='dbble-bgr'>";
             dbubble += "<span class='dbble-bgr1'>"+dbspn1+"</span>";
             dbubble += "<span class='dbble-bgr2'>"+dbspn2+"</span>";
           dbubble += "</div>";

           dbubble += "<span class='dbble-pnt'></span>";

        dbubble += "</div>";

        contain.html(dbubble);

        $(".dbble-cont").animate({
          opacity: '0.1'
        },10000);

        $(".dbble-pnt").animate({
          width: '10px',
          height: '10px',
          left: '16px',
          top: '82px'
        },4000);
  }     
}


function subNewslater($this, form_id){

  var formdata = $($this).serialize();
  var url = $($this).attr("action");
  var sumitbtn =  $(".subssbscribe");
  $(form_id+" .mailchimpsuccess, "+form_id+" .mailchimperror").text("");
  var oldfval = sumitbtn.val();
 
  sumitbtn.val(oldfval+"...")
  sumitbtn.attr("disabled",true);



  $.ajax({
    url: url,
    type: "post",
    data: formdata,
    dataType: "json",
    success: function(resp){

      sumitbtn.val(oldfval);
      $(form_id+" .subscribemail").val("");
      if (resp.success) {
        $(form_id+" .mailchimpsuccess").text(resp.msg);
        $(form_id+" .subscribemail").val("");
      }else{
        var errors = "<li class='err-head'>"+resp.msg+"</li>";
        //errors += resp.errors.join(". ");

         for(var error in resp.errors ){
          errors += "<li>"+error+": "+resp.errors[error]+" </li>";
         }
        $(form_id+" .mailchimperror").html(errors);

        sumitbtn.removeAttr("disabled");
      }
    }
  })
  return false;

}

// <iframe width="560" height="315" 
//src="https://www.youtube.com/embed/pNb1HxKFYWE" ></iframe>

function showVidoFroncontent(){
   $("body a").each(function(a){
    var thref = $(this).attr("href");
    if(typeof(thref) != "undefined"){
      if(thref.indexOf("embed-y") != -1){
        var tarray = thref.split("/");
     var tcode = tarray[tarray.length-1];

        if(typeof(tcode) !="undefined"){

            var youtb = '<iframe width="560" height="315"'; 
            tcode = tcode.replace("&embed-y","");
            youtb += ' src="https://www.youtube.com/embed/'+tcode+'?rel=0&amp;controls=1&amp;showinfo=0"'; 
            youtb += ' frameborder="0" allow="autoplay; encrypted-media"';
            youtb += ' autoplay="1" ';
            youtb += ' allowfullscreen></iframe>';
            $(this).html(youtb)
        }
      }
    }
   })
}


function showCurrencyPrice(cntr = 0){
  if(cntr < 0 || typeof(cntr) == "undefined" || cntr > 8){
    return false;
  }
  var cnara = '<i class="flaticon-nigeria-naira-currency-symbol"></i>';
  var cendi = '<i class="flaticon-ghana-cedis"></i>';
  var wrapper = '.nav.nav-pills li a.lnk';

  var curobj = [
          { m: "usdngn", s: cnara },
          { m: "gbpngn", s: cnara },
          { m: "ghsngn", s: cnara },
          { m: "btcngn", s: cnara },
          { m: "btcusd", s: "$" },
          { m: "btcgbp", s: "£" },
          { m: "usdghs", s: cendi },
          { m: "gbpghs", s: cendi },
          { m: "btcghs", s: cendi }
          ];

          //for(var i=0; i<curobj.length; i++){
             
            var pobj = curobj[cntr];
            //setTimeout(function(){
             // alert(curobj[i])
              if(typeof(pobj) != "undefined"){
                $.ajax({
                type: 'GET',
                dataType: "json",
                url: "/markets/"+pobj.m,
                dataType: "json",
                success:function(data){
                  if(data.trades[0]){
                    price = data.trades[0]['price'];

                    var nhtml = pobj.s+""+price;

                    var nobj = '<span class="csymble">'+nhtml+'</span>';
                    //alert(wrapper+"."+pobj.m)
                    $(wrapper).each(function(){
                      if ($(this).attr("datas") == pobj.m ) {
                        $(this).append(nobj);
                      }
                    })
                    showCurrencyPrice(cntr+1);
                    //$(wrapper+"datas").append(nobj);
                  }
                }
                })
              }
                
            //},2*1000);    
          //}


        // $.ajax({
        //   type: 'GET',
        //   dataType: "json",
        //   url: url,
        //   dataType: "json",
        //   success:function(data){
        //    if(data.trades[0])
        //      price = data.trades[0]['price'];
        //    if(data.asks[0])
        //     ask_rate=data.asks[0][0];
        //    if(data.bids[0])
        //     bids_rate=data.bids[0][0];
        // }
}


