var customSimpleMDE = function() {
  self = this;

  self.getImages = function(editor) {
    $.ajax({
      url: '/admin/images',
      dataType: "script"
    })
  }

  self.getContentUpgrades = function(editor) {
    $.ajax({
      url: '/admin/insert_content_magnets',
      dataType: "script"
    })
  }

  self.toolbar = [
      "bold", "italic", "heading", "|", 
      "quote", "unordered-list", "ordered-list", "|", 
      "link", 
      {
        name: "getImages",
        action: self.getImages,
        className: "fa fa-picture-o",
        title: "Insert image"
      },
      {
        name: "getContentUpgrade",
        action: self.getContentUpgrades,
        className: "fa fa-file-text-o",
        title: "Insert Content Upgrade"
      },
      "|",
      "preview", "side-by-side", "fullscreen", "|",
      "guide"
  ]

  self.insertContentUpgradeCallout = function(result,responseStatus,xhr) {
    var cm = simplemde.codemirror;
    var output = '';
    var selectedText = cm.getSelection();
    var text = selectedText || title;

    output = result.callout_html;
    cm.replaceSelection(output);

    $('#global-modal').modal('hide');
  }

  var initAddImage = function() {
    $(document).on('click', '.js-addImage', function(e) {
      url = $(e.target).data('url')
      var cm = simplemde.codemirror;
      var output = '';
      var selectedText = cm.getSelection();
      var text = selectedText || 'placeholder';

      output = '![](' + url + '){: .img-responsive.img-content}';
      cm.replaceSelection(output);

      $('#global-modal').modal('hide');
    })
  }

  var initAddContentUpgradeLink = function() {
    $(document).on('click', '.js-addContentUpgradeLink', function(e) {
      e.preventDefault();
      url = $(e.target).data('url');
      title = $(e.target).data('title');
      var cm = simplemde.codemirror;
      var output = '';
      var selectedText = cm.getSelection();
      var text = selectedText || title;

      output = '['+text+'](' + url + '){: .js-getContentMagnet}';
      cm.replaceSelection(output);

      $('#global-modal').modal('hide');
    })
  }

  var initAddContentUpgradeCallout = function() {
    $(document).on('submit', '.js-addContentUpgradeCallout', function(e) {
      e.preventDefault();
      $.ajax({
        url: '/admin/insert_content_magnets',
        method: "POST",
        data: $(e.target).serialize(),
        dataType: "json",
        success: self.insertContentUpgradeCallout
      });
    })

  }

  self.init = function(elementId) {

    simplemde = new SimpleMDE({
      element: document.getElementById("body-markdown"),
      toolbar: self.toolbar
    })


    initAddImage();
    initAddContentUpgradeLink();
    initAddContentUpgradeCallout();
  }
}
//End customSimpleMDE

var imageDropzone = function() {
  self = this;
  self.acceptedFiles = ".jpeg,.jpg,.png,.gif";
  self.prependImage = function(media, id) {
    $('.image-container').prepend('<div class="image-wrapper" id="img-' + id + '">' + 
      '<img src="'+ media.thumb_url +'" class="img-responsive js-addImage" data-url="'+media.original_url+' "data-id="'+id+'"></img>' +
      '<ul class="list-inline">' +
      '<li>' + id + '</li>' + 
      '<li><a class="text-danger" rel="nofollow" data-method="delete" data-remote="true" href="/admin/images/'+id+'">' + 
      '<i class="fa fa-trash"></i>' +
      '</a>' + 
      '</li>' +
      '</ul>'
    )
  }

  self.create = function(element, url, param) {
    myDropzone = new Dropzone(element, {
      url: url,
      paramName: param,
      acceptedFiles: self.acceptedFiles
    })

    myDropzone.on("complete", function(files) {
        var that = this;
        if (myDropzone.getUploadingFiles().length === 0 && myDropzone.getQueuedFiles().length === 0) {
          setTimeout(function(){
            var acceptedFiles = myDropzone.getAcceptedFiles();
            var rejectedFiles = myDropzone.getRejectedFiles();
            for(var index = 0; index < acceptedFiles.length; index++) {
              var file = acceptedFiles[index];
              var response = JSON.parse(file.xhr.response);
              self.prependImage(response.media, response.id);
            }
            if(rejectedFiles.length != 0) {
              alert('Error uploading ' + rejectedFiles.length + ' files. Only image files are accepted.');
            }
            myDropzone.removeAllFiles();
          }, 500);
        }
    });

  }

}
//END imageDropzone

$(document).on('click', '.js-addImage', function(e) {
  id = $(e.target).data("id");
  url = $(e.target).data("url");
  $('#global-modal').modal('hide');
  $('#js-resource-logo-id').val($(e.target).data("id"));
  $('#img-wrapper').html("");
  $('#img-wrapper').html('<img src="' + url + '" class="img-thumbnail"></img>');
});

$(document).on('click', '.js-getContentMagnet', function(e) {
  e.preventDefault();
  $.ajax({
    method: "GET",
    url: $(e.target).attr("href"),
    dataType: "script"
  });
});

$(document).on("turbolinks:load", function() {
  if ( document.getElementById('body-markdown') ) {
    var simplemde = new customSimpleMDE("body-markdown");
    simplemde.init();
  }

  // Disable auto discover for all elements:
  Dropzone.autoDiscover = false;
})
