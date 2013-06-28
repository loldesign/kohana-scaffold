<?php defined('SYSPATH') or die('No direct script access.');

class Controller_Application extends Controller_Template {

	public $template = 'layout/application';

	public function before()
	{
		parent::before();
		$this->template->title = "KohanaScaffold";
	}

	public function after()
	{
		$this->response->body($this->template);
	}

} // End Application
