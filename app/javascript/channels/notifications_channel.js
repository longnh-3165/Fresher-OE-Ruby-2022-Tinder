import consumer from "./consumer"
consumer.subscriptions.create({channel: "NotificationsChannel"}, {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    const counter = `${data.count}`
    const content = `<p>${data.notification.content}</p> <span>${data.notification.created_at}</span><div class="dropdown-divider"></div>`

    $(".js-counter").html(counter)
    $(".js-dropdown-menu-content").html(content)
  }
})
