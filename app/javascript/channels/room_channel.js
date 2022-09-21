import consumer from "./consumer"
document.addEventListener('turbolinks:load', () => {

  const room_element = document.getElementById('room-id');
  const room_id = room_element.getAttribute('data-room-id');

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    consumer.subscriptions.remove(subscription)
  })

  consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      const user_element = document.getElementById("user-id");
      const user_id = Number(user_element.getAttribute("data-user-id"));
      let html;
      if(data.sender == user_id) {
        html = data.html_sender
      }else if (user_id == data.receiver){
        html = data.html_receiver
      }else{
        html = ""
      }
    $("#js-msg-box").append(html)
    html = "";
    $(".clear-chat").val("");
    $("ul#js-msg-box").scrollTop($("ul#js-msg-box")[0].scrollHeight);
    }
  })
});
