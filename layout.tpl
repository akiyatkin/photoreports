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
			<div><i>{~date(:j F Y,date)}</i></div>
			<div class="text-right">
				<a data-anchor=".breadcrumb" href="/{crumb}/{name}">Подробней</a>
			</div>
		</div>
		<div class="col-sm-6 phorts-preview">
			<style scoped>
				.phorts-preview img {
					padding:2px;
					width:25%;
				}
			</style>
			{gallery?gallery::img?video::video}
			<div class="clear:both"></div>
		</div>
	</div>
	{img:}{~key<:8?:imgshow}{imgshow:}<a data-anchor=".breadcrumb" href="/{crumb}/{...name}#{.}"><img src="/-imager/?w=400&h=300&crop=1&src={...gallerydir}{.}"></a>
	{video:}{~key<:8?:imgshow2}{imgshow2:}<a href="/{crumb}/{...name}"><img src="https://i.ytimg.com/vi/{id}/hqdefault.jpg"></a>
{breadpage:}<li class="active">{data.info.heading}</li>
{page:}
	<ol class="breadcrumb">
		<li><a href="/">Главная</a></li>
		<li><a data-anchor=".breadcrumb" href="/{parent.crumb}">{parent.config.title}</a></li>
		{data.info.heading:breadpage}
	</ol>
	{data.text}
	<div class="phorts-list">
		<style scoped>
			.phorts-list {
				margin-left:-5px;
				margin-right:-5px;
			}
			.phorts-list img {
				padding:5px;
				width:20%;
			}
		</style>
		{data.info.gallery::bigimg}
	</div>
	<a href="/{parent.crumb}">{parent.config.title}</a>
	<script>
		domready(function(){
			var div=$('.phorts-list');
			if (!div.magnificPopup) {
				console.info('Требуется magnificPopup');
				return;
			}
			div.find('a').magnificPopup({
				type: 'image',
				gallery:{
					enabled:true
				}
			});
			var hash = location.hash;
			if(hash){
				hash = hash.replace(/^#/,'');
				if (hash=='show') {
					div.find('a:first').click();
				} else {
					
					var el = document.getElementById('img-'+hash);
					$(el).click();
				}
			}
		});
	</script>
	{bigimg:}<a id="img-{.}" href="/{...gallerydir}{.}"><img style="width:20%" src="/-imager/?w=400&h=300&crop=1&src={...gallerydir}{.}"></a>
