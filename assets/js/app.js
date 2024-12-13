 // TODO: liniting for the javascript files
 import "phoenix_html"
 import {Socket} from "phoenix"
 import {LiveSocket} from "phoenix_live_view"
 import topbar from "../vendor/topbar"
 let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
 let Hooks = {}
 Hooks.UpdatePainsnake = {
   mounted() {
     window.addEventListener("phx:update_painsnake", (event) => {
      this.pushEvent("update_painsnake", event.detail)
     })
   }
 }

 let liveSocket = new LiveSocket("/live", Socket, {
   hooks: Hooks,
   params: {_csrf_token: csrfToken}
 })

 // Show progress bar on live navigation and form submits
 topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
 window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
 window.addEventListener("phx:page-loading-stop", _info => topbar.hide())
//   function debounce(func, wait) {
//    let timeout;
//    return function(...args) {
//      const context = this;
//      clearTimeout(timeout);
//      timeout = setTimeout(() => func.apply(context, args), wait);
//    };
//  }

 document.addEventListener("DOMContentLoaded", () => {
   document.querySelectorAll("[contenteditable=true]").forEach(element => {
     element.addEventListener("blur", event => {
       const id = event.target.getAttribute("phx-value-id");
       const newName = event.target.innerText.trim();

       if (id && newName) {
         const payload = { id: id, category_name: newName };
         const event = new CustomEvent("phx:update_painsnake", { detail: payload });
         console.log("dispatching phx:update_painsnake", payload);
         window.dispatchEvent(event);
       }
     });
   });
 });
 liveSocket.connect()
 window.liveSocket = liveSocket