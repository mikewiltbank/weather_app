$(document).ready(function() {
  $('#temp-conversion button').click(function() {
    $(this).addClass('active').attr('disabled', true);
    $(this).siblings().removeClass('active').removeAttr('disabled');

    if (this.id === 'to-celsius') {
      fahrenheitToCelcius()
    } else {
      celciusToFahrenheit()
    }
  });

  $(".location-remove").click(function() {
    $(this).parents().eq(2).remove();

    $.ajax({
      url: "/weather_locations/" + this.id,
      type: 'delete',
      success: function() {
        console.log('Successfully Destroyed Weather Location');
      },
      error: function(error) {
        console.log(error);
      }
    });
  });

  $('#warning').click(function() {
    this.parentElement.remove();
  });

  $("#refresh-all").click(function() {
    $.ajax({
      url: "/weather_locations/update_all",
      type: 'put',
      success: function() {
        console.log('Successfully Updated All Weather Locations');
      },
      error: function(error) {
        console.log(error);
      }
    });
  });

});

function fahrenheitToCelcius() {
  $('.temperature').each(function() {
    let temp = parseFloat(this.textContent);

    this.innerHTML = ((temp - 32) / 1.8).toFixed(1);
  });

  $('.temp-type').text('C');
}

function celciusToFahrenheit() {
  $('.temperature').each(function() {
    let temp = parseFloat(this.textContent);

    this.innerHTML = ((temp * 1.8) + 32).toFixed(1);
  });

  $('.temp-type').text('F');
}
