//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-wysihtml5/b3
//= require bootstrap-datetimepicker
//= require bootstrap-datepicker
//= require ZeroClipboard
//= require moment
//= require admin/app










function senMsgToSubscr($this){

   var formdata = $($this).serialize();
  var url = $($this).attr("action");
  var sumitbtn =  $(".subssbscribe");
 
  var oldfval = "Send";
 
  sumitbtn.val("Sending please wait...")
  sumitbtn.attr("disabled",true);

  $.ajax({
    url: url,
    type: "post",
    data: formdata,
    dataType: "json",
    success: function(resp){

      sumitbtn.val(oldfval);
      $("#subscriber_contents").val("");
      if (resp.success) {
        $(".form_success").text(resp.msg);
        setTimeout(function(){
        	$('#senMsgModel').modal('hide');
        },3000);
        
      }else{
        var errors = "<b class='err-head'>"+resp.msg+"</b>";
        errors += '<p>'+resp.errors+'</p>';
        
        $(".form_erros").html(errors);

        sumitbtn.removeAttr("disabled");
         
      }
    }
  })
  return false;
};

$(document).ready(function(){
  var d = new Date();
  $('input.datepicker').datepicker(
    { 
      format: "mm-dd-yyyy",
      maxDate: 0,
      endDate: d,
      autoclose: true
      //startDate:'+'+d.getMonth()+'/'+d.getDate()+'/'+d.getYear() 
    }).change(function(){
       var t = $(this).data("target");
        if(typeof(t) != "undefined"){
           
          $(".searchbydate").data(t,$(this).val()); 
           
        }
    }) 
})

function validateSrDates(){
  var s,e,a;
  s = $(".datepicker.sd").val();
  e = $(".datepicker.ed").val();

  if (s == "") {
    alert("Please Select the Start Date!");
    return false;
  }
  s = moment(s, 'MM-DD-YYYY');
  e = moment(e, 'MM-DD-YYYY');

  a = e.diff(s, 'days');

  if(!(a >= 0)){
    alert("End date must be greater or equals to Start Date!");
    return false;
  } 
  return true;
}

function srchFinances($this){
  var c,s,e,p,url,pager;
  url = $($this).attr("href");
  p = $($this).data("page");
  c = $($this).data("currency");
  s = $($this).data("sd");
  e = $($this).data("ed");
  
  
  url += "?" 
  if (p!= null && typeof(p)!= "undefined" && p!= "") {
     
    url += "page="+p;
  }
  if (c!= null && typeof(c)!="undefined" && c!="") {
    url += "&currency="+c;
  } 
  if (s!= null && typeof(s)!="undefined" && s!="") {
    url += "&sd="+s;
  } 
  if (e!= null && typeof(e)!="undefined" && e!="") {
    url += "&ed="+e;
  } 

  if(validateSrDates()){
     window.location = url;
  }

 

  return false;
}
