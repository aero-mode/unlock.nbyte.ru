{% extends "main.tpl" %}
{% block title %}Статьи / {{global_title}}{% endblock %}
{% block body %}
<div class="middle">
	<div class="container">
		<main class="content-sidebar">
			<h1 class="title">Статьи</h1>
			{% for news in news_short %}
				<div class="short_news">
					<div class="short_news_title"><a href="{{news.link}}">{{news.title}}</a></div>
					<div class="short_news_date">{{news.date_add|date("d.m.Y H:i")}}</div>
					<div class="short_news_text">{{news.short_text|raw}}</div>
				</div>
			{% endfor %}
		</main>
	</div>
	{% include "sidebar.tpl" %}
</div>
{% endblock %}