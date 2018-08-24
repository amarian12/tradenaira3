(function() {
  var toUrl;

  $.fn.titleToUrl = function(urlSelector) {
    var titleInput, urlInput;
    titleInput = $(this);
    urlInput = $(urlSelector);
    return titleInput.on('input', function() {
      var url;
      url = toUrl(titleInput.val());
      return urlInput.val(url);
    });
  };

  toUrl = function(title) {
    var url;
    url = title.toLowerCase();
    url = url.replace("'", '');
    url = url.replace(/[^a-z0-9]/g, ' ');
    url = url.replace(/^\s+|\s+$|/g, '');
    url = url.replace(/\s+/g, '-');
    return url;
  };

}).call(this);
