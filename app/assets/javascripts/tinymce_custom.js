$(document).ready(function() {
    if (typeof tinyMCE != 'undefined') {
        tinyMCE.init({
            selector: "textarea.tinymce",
            toolbar: ["insertfile heading2 | bold italic | alignleft aligncenter alignright | outdent indent | link uploadimage | forecolor | code"],
            plugins: "link,uploadimage,textcolor,paste,code",
            statusbar: false,
            menubar: false,
            setup: function (editor) {
                editor.addButton("heading2", {
                    tooltip: "見出し",
                    text: "見出し",
                    onClick: function () {
                        editor.execCommand('mceToggleFormat', false, 'h3');
                    },
                    onPostRender: function () {
                        var self = this, setup = function () {
                            editor.formatter.formatChanged('h3', function (state) {
                                self.active(state);
                            });
                        };
                        editor.formatter ? setup() : editor.on('init', setup);
                    }
                })
            },
            language: "ja",
            uploadimage_default_img_class: "img-fluid",
            init_instance_callback: "setcontent"
        });
    }
});