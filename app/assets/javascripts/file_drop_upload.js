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
    upload: function(event){
        //Get File
        var file = event.originalEvent.dataTransfer.files;
        file = file[0];
        //Get CSRF Token
        var csrf_token = $('meta[name="csrf-token"]');
        csrf_token = csrf_token[0].content;
        //Set Form Data
        var requestData = new FormData();
        requestData.append("piece[image]", file);
        requestData.append("authenticity_token", csrf_token);

        //Send Request
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
    }
};

//Initalize
$(document).on('ready page:load', function () {
    fileDropper.init();
});