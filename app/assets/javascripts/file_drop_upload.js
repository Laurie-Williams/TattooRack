var fileDropper = {
    init: function(){
        var $file_drop_area = $("#file_drop_area");
        $file_drop_area.on('dragover', fileDropper.dragOver);
        $file_drop_area.on('dragleave', fileDropper.dragLeave);
        $file_drop_area.on('drop', fileDropper.drop);
    },
    dragOver: function(){
        $(this).addClass("drag_over");
        return false;
    },
    dragLeave: function(){
        $(this).removeClass("drag_over");
        return false;
    },
    drop: function(event){
        event.preventDefault();
        $(this).removeClass("drag_over");
        fileDropper.upload(event);
    },
    setDropFile: function(event){
        var file = event.originalEvent.dataTransfer.files;
        file = file[0];
        fileDropper.dropFile = file;
    },
    setCsrfToken: function(){
        var csrf_token = $('meta[name="csrf-token"]');
        if (csrf_token.length > 0) {csrf_token = csrf_token[0].content;}
        fileDropper.csrfToken = csrf_token;
    },
    setFormData: function(file, csrf_token){
        //Set Form Data
        var requestData = new FormData();
        requestData.append("piece[image]", file);
        requestData.append("authenticity_token", csrf_token);
        fileDropper.requestData = requestData;
    },
    sendAjaxRequest: function(requestData){
        $.ajax({
            processData: false,
            contentType: false,
            type: 'POST',
            url: "/pieces.json",
            data: requestData,
            success: function(data){
                //    redirect to edit page
                window.location.replace("/pieces/" + data.id + "/edit")
            }
        });
    },
    upload: function(event){
        fileDropper.setDropFile(event);
        var file = fileDropper.dropFile;
        fileDropper.setCsrfToken();
        var csrfToken = fileDropper.csrfToken;
        fileDropper.setFormData(file, csrfToken);
        var requestData = fileDropper.requestData;
        fileDropper.sendAjaxRequest(requestData);
    }
};

//Initalize
$(document).on('ready page:load', function () {
    fileDropper.init();
});