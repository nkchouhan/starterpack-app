$(document).on 'ready page:load', ->
  $(".image_container").on "click", ->
    id = "#" + $(this).data("name")
    $(id).click()
    return

  $("#photos").validate
    rules:
      title:
        required: true
    messages:
      title:
        required: "Please input"

  $("#photos").submit (event) ->
    arr = ["photo_first", "photo_second", "photo_third", "photo_four"]
    arr_ele = []
    $.each arr, (index, value) ->
      if $("#"+value).val().length >= 1
        $($.find "[data-name='" + value + "']").removeClass('error_box')
        arr_ele.push 1
      else
        $($.find "[data-name='" + value + "']").addClass('error_box')
        arr_ele.push 0

    valid = ($.inArray(0, arr_ele) is -1)
    alert "Please select image" unless valid
    
    return valid

  $(".photo-file-input").on "change", (e) ->
    ext = $(this).val().split(".").pop().toLowerCase()
    not_valid = ($.inArray(ext, [
      "gif"
      "png"
      "jpg"
      "jpeg"
    ]) is -1)
    alert "invalid file type" if not_valid
    if e.target.files and e.target.files[0] and not not_valid
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

