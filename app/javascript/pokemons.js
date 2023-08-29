$(document).ready(function() {
  $("#type-filter-form").on("submit", function(e) {
    e.preventDefault();
    var typeValue = $("#pokemon_type").val();

    $.ajax({
      type: "GET",
      url: $(this).attr("action"),
      data: { pokemon_type: typeValue },
      dataType: "script"
    });
  });
});
