$(document).ready(function(){

  /*
var ajaxGraph = new Rickshaw.Graph.Ajax( {

  element: document.getElementById("chart"),
  width: 400,
  height: 200,
  renderer: 'line',
  dataURL: 'data.json',
  onData: function(d) { d[0].data[0].y = 80; return d },
  series: [
    {
      name: 'New York',
      color: '#c05020',
    }, {
      name: 'London',
      color: '#30c020',
    }, {
      name: 'Tokyo',
      color: '#6060c0'
    }
  ]
} );
*/

function refreshData(){
  $.ajax({
    //url: 'data.json'
    url: '/data',
    success: function(data){
    data = JSON.parse(data);
    var oldTableElement = $('.table-class') ;
    var oldTableDup = $('.table-class').clone().hide();//$('#table-div').html();
    oldTableDup.find('#rows').html('');
    //data.forEach(function(hashtagScore){
    for(var i = 0; i < data.length; i++)
    {
      oldTableDup.find('#rows').append('<tr><td>'+ (i+1) +'</td><td>'+ data[i][0] +'</td><td>'+ data[i][1]  +'</td></tr>');
    };
    //var newTableElement = $('.table-class');//$('#table-div').html();
    oldTableElement.rankingTableUpdate(oldTableDup);
    setTimeout(refreshData, 5000);
    }
  });
  /*
  }).complete(function(data){
    data = JSON.parse(data);
    var oldTableElement = $('#table-div').html();
    data.forEach(function(hashtagScore){
      $('#rows').append('<tr><td></td><td>'+ hashtagScore[0] +'</td><td>'+ hashtagScore[1]  +'</td></tr>');
    });
    var newTableElement = $('#table-div').html();
    $(oldTableElement).rankingTableUpdate(newTableElement);
    setTimeout(refreshData, 5000);
  });
  */
}

function refreshStats(){
  $.ajax({
    //url: 'data.json'
    url: '/stats',
    success: function(data){
      data = JSON.parse(data);
      $('#start-time').text(data['start_time']);
      $('#tweet-count').text(data['tweet_count']);
      setTimeout(refreshStats, 5000);
    }
  });
  /*
  }).complete(function(data){
    data = JSON.parse(data);
    var oldTableElement = $('#table-div').html();
    data.forEach(function(hashtagScore){
      $('#rows').append('<tr><td></td><td>'+ hashtagScore[0] +'</td><td>'+ hashtagScore[1]  +'</td></tr>');
    });
    var newTableElement = $('#table-div').html();
    $(oldTableElement).rankingTableUpdate(newTableElement);
    setTimeout(refreshData, 5000);
  });
  */
}

refreshData();
refreshStats();

});
