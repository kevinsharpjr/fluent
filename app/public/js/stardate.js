$(document).ready(function() {
  
  function leapYear(year) {
    if ((year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0)))
      { return true; }
  }
  
  function calculateTNG_Calc01() {
    origin = new Date("July 5, 2318 12:00:00");
    stardate = $("#stardateValue").val()
    
    stardatesPerYear = stardate * 34367056.4;
    milliseconds = origin.getTime() + stardatesPerYear;
    
    result = new Date();
    result.setTime(milliseconds);
    
    return result;
  }
  
  function calculateTNG_Calc02() {
    stardate = $("#stardateValue").val()
    stardate = Math.abs(stardate);
    
    var staryear = Math.floor(stardate / 1000);
    var startime = stardate % 1000;
    
    var outyear = 2323 + staryear;
    var inyear = outyear;
    var length = (leapYear(inyear)) ? 31622400 : 31536000;
    
    var outtime = startime * length;
    var finalyear = Date.UTC(outyear, 0, 1, 0, 0, 0);
    var finaltime = finalyear + outtime;
    
    var outdate = new Date();
    outdate.setTime(finaltime);
    outdate = outdate.toGMTString();
    
    return outdate;
  }
  
  $('#stardateForm').hide();
  $('#tngEra').hide();
  $('#tosEra').hide();
  $('#tngEraLabel').hide();
  $('#tosEraLabel').hide();
  $('#perYearLabel').hide();
  $('#stardatesPerYear').hide();
  
  $("#enableForm").click(function() {
    if ($("#enableForm").is(":checked")) {
      $('#stardateForm').show();
      
      $('#tngEraLabel').show();
      $('#tosEraLabel').show();
      
      $('#tngEra').show();
      $('#tosEra').show();
      
      $("#tngEra").removeProp("disabled");
      $("#tosEra").removeProp("disabled");
    } else {
      $("#tngEra").prop("disabled", true);
      $("#tosEra").prop("disabled", true);
      
      $("#tngEra").prop('checked', false);
			$("#tosEra").prop('checked', false);
      
      $('#tngEra').hide();
      $('#tosEra').hide();
      $('#tngEraLabel').hide();
      $('#tosEraLabel').hide();
      
      $('#perYearLabel').hide();
      $('#stardatesPerYear').hide();
      
      $("#stardate_instruct").text("Choose a stardate era.");
      $("#calendarValue").val("")
      
      $("#stardateValue").val("")
      $('#stardateForm').hide();
    }
  });
  
  $("#tngEra").click(function() {
    $("#stardate_instruct").text("Enter TNG era stardate:");
    $("#stardateValue").val("42353.7")
    $("#calendarValue").val("")
    
    $('#perYearLabel').show();
    $('#stardatesPerYear').show();
  });
  
  $("#tosEra").click(function() {
    $("#stardate_instruct").text("Enter TOS era stardate:");
    $("#stardateValue").val("1533.7")
    $("#calendarValue").val("")
    
    $('#perYearLabel').hide();
    $('#stardatesPerYear').hide();
  });
  
  $('#convert').click(function() {
    $("#calendarValue").val("")
    
    if ($("#tngEra").is(":checked")) {
      
      if ($("#stardatesPerYear").is(":checked")) {
        alert("per year was checked");
        result = calculateTNG_Calc01();
      } else {
        alert("per year was not checked");
        result = calculateTNG_Calc02();
      }
      
      $("#calendarValue").val(result)
    } else if ($("#tosEra").is(":checked")) {
      origin = new Date("April 25, 2265 00:00:00");
      stardate = $("#stardateValue").val()
      
      stardatesPerYear = stardate * 60 * 60 * 24 * 365.2422 / 2.63510833;
      milliseconds = origin.getTime() + stardatesPerYear;
      
      result = new Date();
      result.setTime(milliseconds);
      
      $("#calendarValue").val(result)
    }
  });
  
});
