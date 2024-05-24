<div class="data" style="min-height:50px;">
{% if opinions != 0 %}
	{% for opinion in opinions %}
		{% if opinion.moderator == 1 %}
		<div style="border:2px solid #000; border-radius:5px; padding: 5px; margin-bottom: 5px; margin-top: 5px; margin-left:25px; margin-right:25px;">
			<b><i>{{opinion.name}}:</i></b>
			<br>{{opinion.text}}
		</div>
		{% else %}
		<div style="border:2px solid #000; border-radius:5px; padding: 5px; margin-bottom: 5px; margin-top: 5px; margin-right:50px;">
			<b>{{opinion.name}}:</b>
			<span style="padding-left:25px;">{{opinion.date}}</span>
			<span style="float:right">{{opinion.rating}}</span>
			<br>{{opinion.text}}
		</div>
		{% endif %}
	{% endfor %}
{% else %}
	Отзывов нет
{% endif %}
</div>
{% if paginations == 1 %}
<div class="pagination">
	<ul>
	{% for page in pages %}
		{% if page.active == 1 %}
			<li p="{{page.page}}" style="color:#fff;background-color:#006699;" class="active">{{page.page}}</li>
		{% else %}
			<li p="{{page.page}}" class="active">{{page.page}}</li>
		{% endif %}
	{% endfor %}
	</ul>
</div>
{% else %}
<div class="pagination">
</div>
{% endif %}