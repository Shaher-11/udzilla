// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "bootstrap"
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all";
import "chartkick/chart.js"
import "../trix-editor-overrides"

import videojs from "video.js"
import 'video.js/dist/video-js.css'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")

require("jquery")
require("jquery-ui-dist/jquery-ui");

$(document).on('turbolinks:load', function(){
  $('.lesson_sortable').sortable({
    cursor: "grabbing",
    cursorAt: { left: 10},
    placeholder: "ui-state-highlight",
    update: function(e, ui){
      let item = ui.item;
      let item_data = item.data();
      let params = {_method: 'put'};
      params[item_data.modelName] = { row_order_position: item.index() }
      $.ajax({
        type: 'POST',
        url: item_data.updateUrl,
        dataType: 'json',
        data: params
      });
    },
    stop: function(e, ui){
      console.log("stop called when finish")
    }
  });

  let videoPlayer = videojs(document.getElementById('my-video'), {
    controls: true,
    playbackRates: [0.5, 1, 1.5],
    autoplay: false,
    fluid: true,
    preload: false,
    autoplay: false,
    liveui: true,
    responsive: true,
    loop: false,
    poster: "https://images.unsplash.com/photo-1536060316316-2466bda904f1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
  })
  videoPlayer.addClass('video-js')
  videoPlayer.addClass('vjs-big-play-centered')
});