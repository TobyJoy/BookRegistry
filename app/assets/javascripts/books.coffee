$(document).on 'click', '.sort_list', ->
  sort_order = $(this).data('sort-order')
  sort_obj = $(this).data('sort-obj')
  $.ajax 
    url: 'sort_books_books.js',
    type: 'GET',
    data: {sort_obj: sort_obj, sort_order: sort_order}

window.attachment_input = (obj) ->
  $(obj).parent().children('.file_field_class').click()
  return  

$(document).on 'change', '#pictureInput', ->
  str = $(this).val()
  pieces = str.split('\\')
  files = event.target.files
  image = files[0]
  filename = pieces[pieces.length - 1]
  val = $(this).val().toLowerCase()
  regex = new RegExp('(.*?).(jpg|jpeg|png|gif)$')
  if ((this.files[0].size < 1048576) && (regex.test(val)) )
    $(this).parent().children('#dropzone').children('#add_attachment_placeholder').val(filename)
    $(".reset_link_default").show()
    $('.reset_link_edit').prev('input[type=hidden]').val('0')
    reader = new FileReader();
    reader.onload = (file) ->
      img = new Image();
      img.src = file.target.result
      $('#target').html(img)
  if (this.files[0].size > 1048576 || !regex.test(val))
    $('.file_field_class').parent().children('#dropzone').children('#add_attachment_placeholder').val('')
    $('.file_field_new').val('')
    $('.dropzone_class').val('')
    $('.reset_link_edit').prev('input[type=hidden]').val('1')
    $(".reset_link_default").hide()
    image_link = $('#target').data('img')
    $('.photo_change > img').attr( "src" , image_link)
  reader.readAsDataURL(image)
  
$(document).keyup (e) ->
  if e.keyCode == 27
    close_modal_window()
    
$(document).on 'click', '.close_window', ->
  close_modal_window()
    
close_modal_window = ->
  $("#model_window_main_view").hide();
  $("#model_window_main_view").html("");
  $(".light_box_wrapper").hide()
  