//Files cannot be added to file fields with javascript.
//To send the Piece data over in the params an AJAX request must be used.
//The parameters are set including the file in the FormData object.
//After the AJAX request is successful the user is redirected to the edit_piece_path

var imageCropper =  {
    init: function(){
        imageCropper.getHtmlViaAjax();

    },
    setRequestData: function(file, csrf_token){
        var requestData = new FormData();
        requestData.append("piece[image]", file);
        requestData.append("authenticity_token", csrf_token);
        requestData.append("piece[crop_x]", $("#crop_x").val());
        requestData.append("piece[crop_y]", $("#crop_y").val());
        requestData.append("piece[crop_height]", $("#crop_height").val());
        requestData.append("piece[crop_width]", $("#crop_width").val());
        imageCropper.requestData = requestData;
    },
    getHtmlViaAjax: function(){ // Get Crop Page HTML
        $.ajax({
            type: 'GET',
            url: "/pieces/crop",
            success: function(data){
                imageCropper.renderCropHtml(data); //Replace HTML with response
            }
        });
    },
    renderCropHtml: function(html){
        var imgFile = fileDropper.file;
        $("body").html(html);
        imageCropper.createImageTagFromFile(imgFile); //Setup cropper on div
        $("#upload").on('click', imageCropper.upload); //Set upload function
    },
    createImageTagFromFile: function(file){
        //To generate a "src" url for an "img" tag that points to a file referenced in javascript memory
        //the file must be read with a file reader that can output the file in DataUrl format
        var fileReader = new FileReader(); //Create a File Reader
        fileReader.readAsDataURL(file); //Load the file data into the reader as data url
        fileReader.onloadend = function(){//Specify what to do when file finishes loading into File Reader
            var $img = $("<img>");
            $img.attr("src", fileReader.result);
            var $cropArea = $("#crop_area");
            $cropArea.append($img);
            imageCropper.setCropper($img);
        }
    },
    setCropper: function(target){
        target.cropper({
            aspectRatio: 1/0.75,
            strict: true,
            responsive: true,
            background: false,
            modal: true,
            preview: ".img-preview",
            highlight: false,
            guides: false,
            movable: false,
            rotatable: false,
            zoomable: false,
            autoCropArea: 1,
            //mincanvasWidth: 450,
            minContainerHeight: 400,
            crop: function(data) {
                // Output the result data for cropping image.
                var $x = $("#crop_x");
                var $y = $("#crop_y");
                var $height = $("#crop_height");
                var $width = $("#crop_width");
                $x.val(data.x);
                $y.val(data.y);
                $height.val(data.height);
                $width.val(data.width);
            }
        });

    //    setup cropper:
    //    initialize cropper.js
    //    add data bindings
    },
    createPieceViaAjax: function(requestData){ // Create Piece
        $.ajax({
            processData: false,
            contentType: false,
            async: true,
            type: 'POST',
            url: "/pieces.json",
            data: requestData,
            success: function(data){
                //    redirect to edit page
                window.location.replace("/pieces/" + data.id + "/edit")
            }
        });
    },
    upload: function(){
        var $upload_button = $("#upload");
        $upload_button.text("Loading");
        $upload_button.unbind("click");
        var csrfToken = fileDropper.csrfToken;
        var file = fileDropper.file;
        imageCropper.setRequestData(file, csrfToken);
        var requestData = imageCropper.requestData;
        imageCropper.createPieceViaAjax(requestData);
    }
};