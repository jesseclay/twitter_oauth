$(document).ready(function() {
  $('#tweet').on('submit', function(e) {
    e.preventDefault();
    $.ajax ({
      url: this.action,
      method: this.method,
      data: $(this).serialize()
    }).done(function(msg) {
      $('.tweet_result').text("Tweet Successful!");
      $('.job_ids').append("<br><a id="+msg+" href='/status/"+msg+"'>"+msg+"</a>");
      $('#tweet').children().first().val('');
      watchJob(msg);
    }).fail(function(msg){
      $('.tweet_result').text("Uh-oh, something went wrong :/");
    }).always(function(){
      $('.tweet_result').fadeIn(1000);
    });
  });

});

function watchJob(job_id) {
  console.log("in watchJob");
  var jobInProcess = true;
  while (jobInProcess) {
    setTimeout(function() {
      console.log("in timeout");
      jobInProcess = jobInProcess(job_id);
    }, 5000);
  }
}

function jobInProcess(job_id) {
  console.log("in jobInProcess");
    $.ajax ({
      url: '/status/' + job_id,
      method: get
    }).done(function(msg) {
      console.log(msg);
      if (msg) {
        console.log("job complete!");
        return false;
      } else {
        return true;
      }
    });
}
