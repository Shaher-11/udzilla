//black list file attachments
window.addEventListener("trix-file-accept", function(event) {
  event.preventDefault()
  alert("file attachment not supported")
})
