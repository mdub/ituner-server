$(document).ready(function() {

  $("#track-search").autocomplete({
    source: '/search.json',
    minLength: 2
  });
    
  // $("#track-search").autocomplete(, {
  // 
  //   dataType: 'json',
  // 
  //   parse: function(data) {
  //     rows = [] ;
  //     for (var i = 0 ; i < data.length ; i++) {
  //       rows.push({data:data[i], value:data[i].name, result:data[i].name});
  //     }
  //     return rows ;
  //   },
  // 
  //   formatItem: function(row,i,max,query) {
  //     return row.name;
  //   }
  // 
  // });

});
