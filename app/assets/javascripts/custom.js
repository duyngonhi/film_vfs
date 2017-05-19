function click_follow(followed_id) {
  $.ajax({
    type: "POST",
    url: "/relationships",
    data: {followed_id: followed_id},
    datatype: "html",
    cache: "false",
    success: function(response) {
      alert("follow was performed.");
    },
    error: function(){
      alert("error");
    }
  });
}

function click_unfollow(id) {
  $.ajax({
    type: "DELETE",
    url: "/relationships/"+id,
    data: {id: id},
    datatype: "html",
    cache: "false",
    success: function(response) {
      alert("unfollow was performed.");
    },
    error: function(){
      alert("error");
    }
  });
}

function click_like(like_film_id) {
  $.ajax({
    type: "POST",
    url: "/likes",
    data: {like_film_id: like_film_id},
    datatype: "html",
    cache: "false",
    success: function(response) {
      alert("like was performed.");
    },
    error: function(){
      alert("error");
    }
  });
}

function click_unlike(id) {
  $.ajax({
    type: "DELETE",
    url: "/likes/"+id,
    data: {id: id},
    datatype: "html",
    cache: "false",
    success: function(response) {
      alert("unlike was performed.");
    },
    error: function(){
      alert("error");
    }
  });
}
