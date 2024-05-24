<?
class app_view{
	static $setting = array(
		'theme' => TEMPLATE,
		'site' => SITE_PATH
	);
	static protected function index(){
		$loader = new Twig_Loader_Filesystem(TEMPLATE_DIR);
		$twig = new Twig_Environment($loader, array(
			'cache' => false,
			'debug' => true,
		));
		$twig->registerUndefinedFunctionCallback(function ($name) {
			if (function_exists($name)) {
				return new Twig_Function_Function($name);
			}
			return false;
		});
		$twig->addExtension(new Twig_Extension_Debug());
		return $twig;
	}
	public function display($tpl, $setting = array()){
		$setting = array_merge($setting, self::$setting);
		$template = self::index()->loadTemplate('/'.$tpl.'.tpl.twig');
		return $template->render($setting);
	}
}