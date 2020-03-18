// Load images outside of doc.ready for faster loading of first image
var images = [
	'cracked-earth.jpg',
	'duststorm.jpg',
	'gulfmexicosediment.jpg',
	'katrina.jpg',
	'monsoon.jpg',
	'wilkinsiceshelf.jpg'
];
for(i=0;i<images.length;i++){
    img = new Image();
    img.src=images[i];
}
$(function(){
	$('#mural').css('position','relative');
	images.sort(function() {return 0.5 - Math.random()}); // shuffle array
	var last = images.length - 1;
	$('#mural img').attr({'src':'/js/gfdl_menu/'+images[last],'alt':'','title':''}); // replace the static mural image with the last image in the randomized image array	
	$('#mural').css('background-image','url(/js/gfdl_menu/'+images[0]+')');
	setInterval(function(){
		$('#mural img').fadeOut(3000,function(){
			$(this).attr('src','/js/gfdl_menu/'+images[0]).fadeIn('fast',function(){
				images.push(images.shift());
				$('#mural').css('background-image','url(/js/gfdl_menu/'+images[0]+')');
			});
		});
	},8000);
});
