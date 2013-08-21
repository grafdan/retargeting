/*
        function showNav() {
            $(function () {
              var activeTab = $('[href=' + location.hash + ']');
              console.log(activeTab);
              activeTab && activeTab.tab('show');
            });
            $('.nav a').on('shown', function (e) {
              console.log(this);
              window.location.hash = e.target.hash;
            })
        }
*/
        

        $(function() {

            var $allVideos = $("video"),
            $fluidEl = $("body");
/*
            console.log("all videos");
            console.log($allVideos);
            console.log($fluidEl);
*/
        	$allVideos.each(function() {
        	
        	  $(this)
        	    .attr('data-aspectRatio', this.height / this.width)
        	    .removeAttr('height')
        	    .removeAttr('width');
        	
        	});
    
            $(window).resize(function() {
        	
        	  var newWidth = $fluidEl.width();
/*
        	  console.log("Window Resize");
        	  console.log($fluidEl);
        	  console.log("new Width:", newWidth);
*/
        	  $allVideos.each(function() {
        	  
        	    var $el = $(this);
        	    $el
        	        .attr('width',newWidth)
        	        .attr('height',(newWidth * $el.attr('data-aspectRatio'))*1.009);
        	  
        	  });
        	  if(newWidth < 400) {
        	       $(".jumbotron h1").css('font-size','45px');
        	  } else {
        	       $(".jumbotron h1").css('font-size','60px');
            	  
        	  }
        	
        	}).resize();
    	});
