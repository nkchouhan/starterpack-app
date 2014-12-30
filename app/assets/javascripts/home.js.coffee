$(document).on 'ready page:load', ->
  $(".image_container").on "click", ->
    id = "#" + $(this).data("name")
    $(id).click()
    return

  $(".photo-file-input").on "change", (e) ->
    if e.target.files and e.target.files[0]
      tar = "."+$(this).attr('id')
      tar_text = ".no_image_"+$(this).attr('id')
      input = e.target
      reader = new FileReader()
      reader.onload = (e) ->
        filename = input.value.split(/(\\|\/)/g).pop()
        $(tar).attr "src", e.target.result
        $(tar).attr "alt", filename
        $(tar).removeClass "hide"
        $(tar_text).addClass "hide"
        $(".remove-uploaded-photo").prop "checked", false
        return

      reader.readAsDataURL input.files[0]
    return
  return
