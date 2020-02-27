<?php
use infrajs\config\Config;
use infrajs\router\Router;
use infrajs\ans\Ans;
use akiyatkin\boo\Cache;
use infrajs\path\Path;
use infrajs\load\Load;
use infrajs\access\Access;
use infrajs\rubrics\Rubrics;

$ans = array ();

$type = Ans::GET('type');
if (!$type) return Ans::err($ans, 'Необходимо параметр type');

$types = ['list','page'];
if (!in_array($type, $types)) return Ans::err($ans, 'Неожиданный type '.$type.'. Допустимые: '.implode(', ',$types));

$src = Ans::GET('src');
if (!$src) return Ans::err($ans, 'Необходимо параметр src');
if (!Path::isNest('~', $src)) return Ans::err($ans, 'Передан некорректный или небезопасный путь');

if (!Path::theme($src)) return Ans::err($ans, 'Папка с фотогалереями не найдена '.$src);

$ans['src'] = $src;

if ($type == 'list') {
	$lim = Ans::GET('lim','string','0,100');
	$p = explode(',', $lim);
	if (sizeof($p) != 2) return Ans::err($ans, 'Некорректный параметр lim');
	list($start, $count) = $p;
	
	$chunk = Ans::GET('chunk','int',0);
	$order = Ans::GET('order',['ascending','descending'], 'descending');
	
	$list = Cache::func( function ($src, $order) {
		$list = array();
		array_map(function ($file) use (&$list, $src) {
			if ($file[0] == '.') return;
			if ($file[0] == '~') return;//Скрытый файл Word
			if (!is_file(Path::theme($src).$file)) return;
			$fd = Load::nameinfo($file);
			if (!in_array($fd['ext'], array('docx', 'html', 'tpl'))) return;
			$list[] = Rubrics::info(Path::toutf($src.$file));
		}, scandir(Path::theme($src)));
		Load::sort($list, $order);
		return $list;


	}, array($src, $order),['infrajs\\access\\Access','getDebugTime']);
	$list = array_slice($list, $start, $count);
	
	if ($chunk) {
		$list = array_chunk($list, $chunk);
	}
	
	$ans['list'] = $list;
} else if ($type == 'page') {
	if ($type == 'page') $id = Ans::GET('id');
	if (!$id) return Ans::err($ans, 'Для type=page необходимо указать id страницы');
	$src = Rubrics::find($src, $id);
	if ($src) {
		$ans['info'] = Rubrics::info($src);
		$ans['text'] = Rubrics::article($src);
	}
}

return Ans::ret($ans);