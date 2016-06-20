{root:}
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li class="active">{config.title}</li>
	</ol>
	<h1>{config.title}</h1>
	{data.list::show}
{show:}
	<h2 style="margin-top:0">{heading}</h2>
	<div class="row space">
		<div class="col-sm-6">
			
			{preview}
			<div>{~date(:j F Y,date)}</div>
			<div class="text-right">
				
				<a data-anchor=".breadcrumb" href="/{crumb}/{name}">Подробней</a>
			</div>
		</div>
		<div class="col-sm-6">
			{gallery::img}
			{~length(gallery)>:0?:imgmore}
			<div class="clear:both"></div>
		</div>
	</div>
	{imgmore:}<div class="text-right"><a data-anchor=".breadcrumb" href="/{crumb}/{name}#show">Показать</a></div>
	{img:}{~key<:8?:imgshow}{imgshow:}<a data-anchor=".breadcrumb" href="/{crumb}/{...name}#{.}"><img style="width:25%" src="/-imager/?w=400&h=300&crop=1&src={...gallerydir}{.}"></a>
{page:}
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a data-anchor=".breadcrumb" href="/{parent.crumb}">{parent.config.title}</a></li>
		<li class="active">{data.info.heading}</li>
	</ol>
	{data.text}
	<div class="gallery">
		{data.info.gallery::bigimg}
	</div>
	<script>
		domready(function(){
			$('.gallery a').magnificPopup({
				type: 'image',
				gallery:{
					enabled:true
				}
			});
			var hash = location.hash;
			if(hash){
				hash = hash.replace(/^#/,'');
				if (hash=='show') {
					$('.gallery a:first').click();
				} else {
					
					var el = document.getElementById('img-'+hash);
					$(el).click();
				}
			}
		});
	</script>
	{bigimg:}<a id="img-{.}" href="/{...gallerydir}{.}"><img style="width:20%" src="/-imager/?w=400&h=300&crop=1&src={...gallerydir}{.}"></a>