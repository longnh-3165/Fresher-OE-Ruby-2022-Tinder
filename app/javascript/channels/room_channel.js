import consumer from "./consumer"
document.addEventListener('turbolinks:load', () => {

  const room_element = document.getElementById('room-id');
  const room_id = room_element.getAttribute('data-room-id');

  consumer.subscriptions.create({channel: "RoomChannel", room_id: 1}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      const user_element = document.getElementById("user-id");
      const user_id = Number(user_element.getAttribute("data-user-id"));
      let html;
      if(data.current_user == user_id) {
        html = data.html_sender
      }else{
        html = data.html_receiver
      }
    $("#js-msg-box").append(html)
    $(".clear-chat").val("");
    $("ul#js-msg-box").scrollTop($("ul#js-msg-box")[0].scrollHeight);
    }
  })
});
