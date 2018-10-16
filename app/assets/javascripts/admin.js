//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-wysihtml5/b3
//= require bootstrap-datetimepicker
//= require ZeroClipboard
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
