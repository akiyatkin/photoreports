<?php
use infrajs\config\Config;
use infrajs\router\Router;
use infrajs\ans\Ans;
use infrajs\path\Path;
use infrajs\load\Load;
use infrajs\access\Access;
use infrajs\rubrics\Rubrics;

if (!is_file('vendor/autoload.php')) {
	chdir('../');
	require_once('vendor/autoload.php');
	Router::init();
}

$ans = array ();



$type = Ans::GET('type');
if (!$type) return Ans::err($ans, 'Необходимо параметр type');

$types = ['list','page'];
if (!in_array($type, $types)) return Ans::err($ans, 'Неожиданный type '.$type.'. Допустимые: '.implode(', ',$types));



$name = Ans::GET('name');
if (!$name) return Ans::err($ans, 'Необходимо параметр name');
if (preg_match('/\//',$name)) return Ans::err($ans, 'name содержит запрещённые символы '.$name);

$src = '~'.$name.'/';

$dir = Path::theme($src);
if (!$dir) return Ans::err($ans, 'Папка с фотогалереями не найдена '.$src);

$ans['src'] = $src;

if ($type == 'list') {
	$lim = Ans::GET('lim','string','0,100');
	$p = explode(',', $lim);
	if (sizeof($p) != 2) return Ans::err($ans, 'Некорректный параметр lim');
	list($start, $count) = $p;

	$list = Access::cache(__FILE__, function(){
		$list = array();
		array_map(function ($file) use (&$list, $dir, $src) {
			if ($file{0} == '.') return;
			if ($file{0} == '~') return;//Скрытый файл Word
			if (!is_file($dir.$file)) return;
			$fd = Load::nameinfo($file);
			if (!in_array($fd['ext'], array('docx', 'html', 'tpl'))) return;
			$list[] = Rubrics::info(Path::toutf($src.$file));
		}, scandir ($dir));
		Load::sort($list);
		return $list;
	});
	$list = array_slice($list, $start, $count);
	
	
	$ans['list'] = $list;
} else if ($type == 'page') {
	if ($type == 'page') $id = Ans::GET('id');
	if (!$id) return Ans::err($ans, 'Для type=page необходимо указать id страницы');
	$src = Rubrics::find($src, $id);
	$ans['info'] = Rubrics::info($src);
	$ans['text'] = Rubrics::article($src);
}

return Ans::ret($ans);