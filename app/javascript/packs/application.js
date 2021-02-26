// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "bootstrap"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import jQuery from "jquery"
import "@fortawesome/fontawesome-free/js/all";

import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")

$(document).ready(()=>{
  
  $(".affixed-bottom-center").on("click", (e)=>{
    $([document.documentElement, document.body]).animate({
      scrollTop: $(".carousel-control-prev").offset().top
    }, 500);
  })

  $(window).scroll((e)=>{
    let fromTop = $(window).scrollTop()
    if(screen.width < 1024){
      $(".affixed-bottom-center").hide()
    } else{
      if(fromTop > 200){
        $(".affixed-bottom-center").hide()
      } else if(fromTop < 100){
        $(".affixed-bottom-center").show()
      }      
    }

  })
})