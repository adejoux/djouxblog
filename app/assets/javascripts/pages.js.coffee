# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

ready = ->
  if $('#epiceditor').length > 0
    editor = new EpicEditor({container: "epiceditor", textarea: 'page_content', clientSideStorage: false }).load()
  # Delete a comment
  $(document)
    .on "ajax:beforeSend", ".comment", ->
      $(this).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment", ->
      $(this).hide('fast')
    .on "ajax:error", ".comment", ->
      $(this).fadeTo('fast', 1)
  $('#page_publish_at').AnyTime_picker({
    format: "%Y-%m-%d %H:%i:%s %E %#",
    formatUtcOffset: "%: (%@)",
    hideInput: true,
    placement: "inline"
  });
$(document).ready(ready)
$(document).on('page:load', ready)
