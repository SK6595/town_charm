$(document).on("turbolinks:load", () => {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#post_address': '%3%4%5'
    }
  });
});