//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-wysihtml5/b3
//= require bootstrap-datetimepicker
//= require bootstrap-datepicker
//= require ZeroClipboard
//= require clipboard
//= require moment
//= require admin/app

//= require js.cookie
//= require jstz
//= require browser_timezone_rails/set_time_zone


function senMsgToSubscr($this){

   var formdata = $($this).serialize();
  var url = $($this).attr("action");
  var sumitbtn =  $(".subssbscribe");
 
  var oldfval = "Send";
 
  sumitbtn.val("Sending please wait...")
  sumitbtn.attr("disabled",true);

  //alert(JSON.stringify(formdata));
  var cont_data = CKEDITOR.instances.subscriber_contents.getData();
  var authenticity_token = $($this).find("input[name=authenticity_token]").val();
  var subject = $("#subscriber_subject").val();
  var active_only = $("#subscriber_active_only").prop("checked") ? 1 : 0;
  formdata = {
    utf8: "✓",authenticity_token: authenticity_token,subscriber: {
      subject: subject, contents: cont_data, active_only: active_only
    }
  }
  
  //return false;
  //alert(CKEDITOR.instances.editor1.getData())

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

    var editableobj = $(".selfeditobject");
    if(editableobj[0]){
      editableobj.click(function(){
        $(this).attr("type","text")
      })
      .blur(function(){
         $(this).attr("type","button");
         updateSelfEditObject(this) 
      })
    }

    if($(".live_counter")[0]){

        setInterval(function(){
          liveCounter();
        },4000);

        $(".live_counter a").click(function(){
          $(".live_counter .counter_info").toggle();
          return false;
        })
    }

    
     copyToclipBoard();
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

function liveCounter(){

  var livecl = $(".live_counter");
  var counter_info = $(".counter_info");
  var info_html, user;
  if (livecl[0]) {
    $.ajax({
      url: "/admin/visitors_counter",
      type: "post",
      dataType: "json",
      success: function(resp){
          console.log(resp);
        //alert(JSON.stringify(resp))
        if(resp.success){
          cntr_html = '<span>'+resp.vcs.length+'</span>';
          $(".live_counter a span.cntr").html(cntr_html);

          info_html = "<table class='table info-inner'>";

          //total signed in users
          info_html += '<tr>';
            info_html += '<td colspan=2>';
              info_html += 'Total Signed in users: ';
            info_html += '</td>';
            info_html += '<td>';
              info_html += resp.signed_in_count;
            info_html += '</td>';
          info_html += '</tr>';

          //total unsigned in users
          info_html += '<tr>';
            info_html += '<td colspan=2>';
              info_html += 'Total Unknown visitors:';
            info_html += '</td>';
            info_html += '<td>';
              info_html += (resp.vcs.length - resp.signed_in_count);
            info_html += '</td>';
          info_html += '</tr>';

          info_html += '<tr>';
            info_html += '<td>';
              info_html += 'user#';
            info_html += '</td>';
            info_html += '<td>';
              info_html += "Email";
            info_html += '</td>';

            info_html += '<td>';
              info_html += "IP Address";
            info_html += '</td>';
          info_html += '</tr>';

          for(var i=0; i<resp.vcs.length; i++){
            vc = resp.vcs[i];
            
              info_html += '<tr>';
                info_html += '<td>';
                if(vc.member_id > 0){
                  info_html += vc.member_id;
                }else{
                  info_html += "N/A";
                }
                info_html += '</td>';
                info_html += '<td>';
                if(vc.member_id > 0){
                  info_html += '<a href="/admin/members/'+vc.member_id+'">';
                    info_html += vc.member.email;
                  info_html += '</a>';  
                }else{
                    info_html += "N/A";
                }  
                info_html += '</td>';

                info_html += '<td>';
                  info_html += vc.ip_address;
                info_html += '</td>';
              info_html += '</tr>';
              
          }

          info_html += "</table>";

          counter_info.html(info_html);
          
        }
      },
      error: function(resp){
         
        //alert(JSON.stringify(resp))
      }

    })
  }
}


function updateSelfEditObject($this){
  var field = $($this).data("field");
  var id    = $($this).data("id");
  var path  = $($this).data("path");
  var model  = $($this).data("model");
  var message = "PS: Field value must be in same formate as it is, Ex: xx Days can be xy Days, but can't be xx Months, are sure update value?"
  if(!confirm(message)){
    return false;
  }
  var value = $($this).val();
  $.ajax({
    url: path,
    method: "post",
    data: { id: id, field: field, value: value, model: model  },
    success: function(resp){
       if(resp.success){
        window.location = "";
       }else{
        alert("Some thing went wrong, bellow log may find the issue..\n "+resp.msg)
       }
    },
    dataType: "json"
  })

}


function copyToclipBoard(){
  var selecter = $(".fa.fa-copy");
  if (selecter[0]) {
    selecter.click(function(){
      var content = $(this).data("clipboard-text");
      //content.select().execCommand("copy");

    })
  }
}
