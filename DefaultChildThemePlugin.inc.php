<?php

/**
 * @file plugins/themes/default/DefaultChildThemePlugin.inc.php
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class DefaultChildThemePlugin
 * @ingroup plugins_themes_default
 *
 * @brief Default theme
 */
import('lib.pkp.classes.plugins.ThemePlugin');

class DefaultChildThemePlugin extends ThemePlugin {
	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */
	public function init() {
		$this->setParent('defaultthemeplugin');
		$this->modifyStyle('stylesheet', array('addLess' => array('styles/remove-borders.less')));
		// Agregando un nuevo archivo de estilos my_accordion.css 
		$this->addStyle('my_accordion', 'styles/my_accordion.css');
		// Agregando un script que agrega nueva funcionalidad al theme
		$this->addScript('my_script', 'js/my_script.js');
		// Habilitando el envio de datos a un template especifico
		HookRegistry::register ('TemplateManager::display', array($this, 'loadTemplateData'));
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName() {
		return __('plugins.themes.default-child.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription() {
		return __('plugins.themes.default-child.description');
	}

	/**
   * Fired when the `TemplateManager::display` hook is called.
   *
   * @param string $hookname
   * @param array $args [$templateMgr, $template, $sendContentType, $charset, $output]
   */
  public function loadTemplateData($hookName, $args) {

    // Retrieve the TemplateManager
    $templateMgr = $args[0];
    $template = $args[1];

    // Don't do anything if we're not loading the right template
    if ($template != 'frontend/pages/article.tpl') {
        return;
    }

    // Obteniendo el arreglo $publishedArticles para enviarlo al template 
    // article.tpl
    $request = Application::getRequest();
    $journal = $request->getJournal();

    // Make sure there's a current issue for this journal
		$issueDao = DAORegistry::getDAO('IssueDAO');
		$issue = $issueDao->getCurrent($journal->getId(), true);
		if (!$issue) return false;

		$publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
		$publishedArticles = $publishedArticleDao->getPublishedArticlesInSections($issue->getId(), true);

    // Attach a custom piece of data to the TemplateManager
    $myCustomData = 'This is my custom data. It could be any PHP variable.';
    $templateMgr->assign(array(
    	'myCustomData' => $myCustomData,
    	'myPublishedArticles' => $publishedArticles
    	));
  }
}

?>
