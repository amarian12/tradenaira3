(function() {
  var PostPreview;

  PostPreview = (function() {
    function PostPreview(buttonId, formId, postUrl, modalId) {
      this.buttonId = buttonId;
      this.formId = formId;
      this.postUrl = postUrl;
      this.modalId = modalId;
      this.button = $("#" + this.buttonId);
      this.form = $("#" + this.formId);
      this.modal = $("#" + this.modalId);
      this.iframe = this.modal.find('iframe');
    }

    PostPreview.prototype.init = function() {
      var callback, url;
      url = this.postUrl;
      callback = this.previewPost;
      return this.button.on('click', (function(_this) {
        return function(event) {
          _this.updateCKeditor();
          event.preventDefault();
          return $.ajax({
            type: "POST",
            url: url,
            data: _this.form.serialize(),
            success: function(data) {
              return _this.previewPost(data);
            }
          });
        };
      })(this));
    };

    PostPreview.prototype.previewPost = function(data) {
      this.iframe.contents().find('html').html(data);
      return document.location.hash = this.modalId;
    };

    PostPreview.prototype.updateCKeditor = function() {
      var instance, name, _ref, _results;
      if (typeof CKEDITOR !== "undefined" && CKEDITOR !== null) {
        _ref = CKEDITOR.instances;
        _results = [];
        for (name in _ref) {
          instance = _ref[name];
          _results.push(instance.updateElement());
        }
        return _results;
      }
    };

    return PostPreview;

  })();

  window.PostPreview = PostPreview;

}).call(this);
