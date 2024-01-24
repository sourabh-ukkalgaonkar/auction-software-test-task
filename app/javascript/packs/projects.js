$(document).ready(function(){
  $('#sort_by').on("change",function(){    
    $.ajax({
      url: `/projects.js?sort_by=${$(this).val()}`,
      type: "get",
      success: function(data) {},
      error: function(data) {}
    });
  });
});  


