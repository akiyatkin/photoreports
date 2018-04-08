<div class="phprojects">
	<div id="phprojects{counter}" class="carousel slide" data-ride="carousel">
		<style scoped>
			/* Since positioning the image, we need to help out the caption */
			.phprojects .carousel-caption {
				z-index: 10;
			}
			.phprojects .carousel-control {
				color:black;
			}
			.phprojects .carousel-control.left {
				background-image: linear-gradient(to right,rgba(255,0,0,.5) 0,rgba(0,0,0,.0001) 100%);
				background-image: none;
			}
			.phprojects .carousel-control.right {
				background-image: linear-gradient(to left,rgba(255,055,0,.5) 0,rgba(0,0,0,.0001) 100%);
				background-image: none;
			}
			/* Declare heights because of positioning of img element */
			
			.phprojects .carousel-caption {
				padding-bottom: 60px;
				
			}
			.phprojects .carousel-indicators {
    			bottom: 0px;
    		}
			.phprojects .carousel-caption h1 {
				padding:20px 30px;
				background-color: rgba(255,255,255,0.4);
				background-color: rgba(0,0,0,0.4);
			}
			.phprojects .carousel-indicators li {
				width: 30px;
				height: 30px;
				margin-left:10px;
				border-radius:20px;
				background-color: {config.color};	
				transition: 0.7s;
			}
			.phprojects .carousel-indicators li:hover {
				background-color: {config.colorhover};	
			}
			.phprojects .carousel-indicators li.active {
				width: 30px;
				height: 30px;
				border-radius:15px;	
				background-color: {config.coloractive};
			}
		</style>
		<!-- Indicators -->
		<ol class="carousel-indicators">
			{data.list::mslidenums}
		</ol>
		<div class="carousel-inner lightlinks" role="listbox">
			{data.list::mslide}
		</div>
		<a data-crumb="false" class="left carousel-control" href="#phprojects{counter}" role="button" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			<span class="sr-only">Previous</span>
		</a>
		<a data-crumb="false" class="right carousel-control" href="#phprojects{counter}" role="button" data-slide="next">
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
</div>
{mslidenums:}
	<li data-target="#phprojects{counter}" data-slide-to="{~key}"{~first()?:mslidenumactive}></li>
	{mslidenumactive:} class="active"
{mslide:}
	<div class="item {~first()?:active}">
		<div class="container" style="padding-bottom:50px">
			<div class="row">
				{::itemslide}
			</div>
		</div>
	</div>
	{itemslide:}
		<div class="col-xs-6 col-sm-3 space {~key=:2?:hidden-xs} {~key=:3?:hidden-xs}">
			<a style="display:block;" href="/projects/{name}">
				<img class="img-responsive" src="/-imager/?h=300&w=350&crop=1&src={gallerydir}{gallery.0}">
				{heading}
			</a>
		</div>
	