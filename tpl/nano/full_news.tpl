{% extends "main.tpl" %}
{% block title %}{{title}} / Новости / {{global_title}}{% endblock %}
{% block keywords %}{{keywords}}{% endblock %}
{% block description %}{{description}}{% endblock %}
{% block body %}
<div class="middle">
	<div class="container">
		<main class="content-sidebar">
			<div class="full_news">
				<h1 class="title">{{title}}</h1>
				<div class="full_news_text">{{text|raw}}</div>
			</div>
		</main>
	</div>
	{% include "sidebar.tpl" %}
</div>
{% endblock %}