# Фотоотчёты для сайта на infrajs

## Описание
Добавляет на сайт раздел с фотоотчётами (Статья и галерея фотографий). Все фототчёты сохраняются в папке с данными. У каждого отчёта есть docx документ с полной статьёй и одноимённая папка с фотографиями. Используется разметка bootstrap.

## Установка через composer

```json
{
	"require":{
		"akiyatkin/photoreports":"~1"
	}
}
```

## Использование
К описанию слоёв контроллера [infrajs/controller](https://github.com/infrajs/controller) нужно добавить слой.

```json
{
			
	"crumb":"reports",
	"config":{
		"title":"Фотоотчёты",
		"order":"descending"
	},
	"external":"-photoreports/layer.json"
}
```
В папку ```~reports/``` нужно добавить статьи docx и папки с фотографиями. Фотоотчёты покажутся на странице проекта по адресу ```/reports```. 


[Пример фотоотчётов](http://bassein-tgu.ru/reports)
