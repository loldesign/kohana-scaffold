<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Welcome extends Controller {

	public function action_index()
	{
		$view = View::factory('layout/template');
		$view->title = "KohanaScaffold";
		$view->content = View::factory('welcome/index');

		$this->response->body($view);
	}

} // End Welcome
