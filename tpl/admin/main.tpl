<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
	<title>{% block title %}{{global_title}}{% endblock %}</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link href="{{theme}}/style.css" rel="stylesheet">
	{% block scripts %}{% endblock %}
</head>
<body>
<div class="wrapper">
{% include "header.tpl" %}
	<div class="middle">
		<div class="container">
			<main class="content">
			{% block body %}
				<ul class="main-block">
					<li>
						<h2 class="sidebar-title">Страницы услуг</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/page_add/">Добавить услугу</a></li>
							<li><a href="/admin/page/">Редактировать услуги</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Категории</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/cat_add/">Добавить категорию</a></li>
							<li><a href="/admin/cat/">Редактировать категории</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Новости</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/news_add/">Добавить новость</a></li>
							<li><a href="/admin/news/">Редактировать новости</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Преимущества</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/advantage_add/">Добавить преимущество</a></li>
							<li><a href="/admin/advantage/">Редактировать преимущества</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Отзывы</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/opinions/">Редактировать отзывы</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Статьи</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/article_add/">Добавить статью</a></li>
							<li><a href="/admin/article/">Редактировать статьи</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Статические страницы</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/static_add/">Добавить страницу</a></li>
							<li><a href="/admin/static/">Редактировать страницы</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Настройки сайта</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/setting/">Настройки сайта</a></li>
						</ul>
					</li>
					<li>
						<h2 class="sidebar-title">Шаблоны</h2>
						<ul class="sidebar-link">
							<li><a href="/admin/templates/">Редактировать шаблон</a></li>
						</ul>
					</li>
				</ul>
			{% endblock %}
			</main>
		</div>
{% include "sidebar.tpl" %}
	</div>
</div>
</body>
</html>