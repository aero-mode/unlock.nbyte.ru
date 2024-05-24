<aside class="left-sidebar">
	{% for sidebar_block in sidebar %}
		<div class="sidebar-page">
			<div class="sidebar-page-img"><a href="{{sidebar_block.link}}"><img width="171" height="130" src="{{sidebar_block.cat_icon}}" alt="{{sidebar_block.title}}"></a></div>
			<div class="sidebar-page-header"><a href="{{sidebar_block.link}}">{{sidebar_block.title}}</a></div>
		</div>
	{% endfor %}
</aside>