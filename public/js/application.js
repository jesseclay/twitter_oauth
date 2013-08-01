$(document).ready(function() {
  var intervalId;

  $('#tweet').on('submit', function(e) {
    e.preventDefault();
    $.ajax ({
      url: this.action,
      method: this.method,
      data: $(this).serialize()
    }).done(function(msg) {
      $('.tweet_result').text("Tweet Successful!");
      $('.job_ids').append("<br><a id="+msg+" href='/status/"+msg+"'>"+msg+"</a>");     
      // $('#tweet').children().first().val('');
      $('.tweetStatus').append("<div id='status_"+msg+"'> Job in process!</div>");
      watchJob(msg);
    }).fail(function(msg){
      $('.tweet_result').text("Uh-oh, something went wrong :/");
    }).always(function(){
      $('.tweet_result').fadeIn(1000);
    });
  });

});

function watchJob(job_id) {
    var count = 1;
    intervalId = setInterval(function() {
      checkJob(job_id, count);
      count++;
    }, 5000);
}

function checkJob(job_id, count) {
    $.ajax ({
      url: '/status/' + job_id,
      method: 'get'
    }).done(function(msg) {
      var result = new String(msg);
      if (result == "true") {
        window.clearInterval(intervalId);
        $('.tweetStatus').text("Job complete! Pinged a total of "+count+" time(s).");
      } else {
        $('.tweetStatus').text("In Process. Pinged "+count+" times so far.");
      }
    });
}
