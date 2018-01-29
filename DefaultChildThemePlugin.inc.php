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
		// Agregando los archivos necesarios para utilizar la biblioteca flag-icon-css
		$this->addStyle('docs', 'flag-icon-css/assets/docs.css');
		$this->addStyle('flag_icon', 'flag-icon-css/css/flag-icon.css');
		// Agregando un script que agrega nueva funcionalidad al theme
		$this->addScript('my_script', 'js/my_script.js');
		// Habilitando el envio de datos a un template especifico
		HookRegistry::register('TemplateManager::display', array(&$this, 'loadTemplateData'));
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
    $request = Application::getRequest();
    $journal = $request->getJournal();
    $issueDao = DAORegistry::getDAO('IssueDAO');

    // Don't do anything if we're not loading the right template
    // La siguiente funcionalidad es para cargar información que no se encontraba
    // disponible en el template frontend/pages/article.tpl
    if ($template == 'frontend/pages/article.tpl') {
    	 // Obteniendo el arreglo $publishedArticles para enviarlo al template article.tpl
	     //Obteniendo el issue al cual pertenece el articulo actual
	    $displayedIssue = $templateMgr->get_template_vars('issue');

	    // Make sure there's a current issue for this journal
			$issue = $issueDao->getCurrent($journal->getId(), true);
			if (!$issue) return false;

			$publishedArticleDao = DAORegistry::getDAO('PublishedArticleDAO');
			/*$publishedArticles = $publishedArticleDao->getPublishedArticlesInSections($issue->getId(), true);*/
			$publishedArticles = $publishedArticleDao->getPublishedArticlesInSections($displayedIssue->getId(), true);

	    // Attach a custom piece of data to the TemplateManager
	    $myCustomData = 'This is my custom data. It could be any PHP variable.';
	    $templateMgr->assign(array(
	    	'myCustomData' => $myCustomData,
	    	'myPublishedArticles' => $publishedArticles
	    	));
    } else if ($template == 'frontend/pages/issueArchive.tpl') {
    	// Obteniendo los números publicados para la revistas
    	$publishedIssuesIterator = $issueDao->getPublishedIssues($journal->getId());
    	$publishedIssueArray = $publishedIssuesIterator->toArray();
    	$countElements = 0;
    	$index = 0;
    	$myArray = array();
    	if ($publishedIssueArray[0] instanceof Issue) {
    		$lastIssue = $publishedIssueArray[0];
    		$datePublished = date_create($lastIssue->getDatePublished());
    		$lastYear = date_format($datePublished, "Y");
    	}
    	foreach ($publishedIssueArray as $value) {
    		if ($value instanceof Issue) {
    			$datePublished = date_create($value->getDatePublished());
    			$currentYear = date_format($datePublished, "Y");
    			if($currentYear == $lastYear){
    				$countElements++;
    			} else {
    				$myArray[$index]['year'] = $lastYear;
	  				$myArray[$index]['elements'] = $countElements;
	  				$lastYear = $currentYear;
	  				$index++;
	  				$countElements = 1;
    			}
    		}
    	}
    	$myArray[$index]['year'] = $lastYear;
  		$myArray[$index]['elements'] = $countElements;
  		// Para debuguear directo al archivo de log de errores de php
    	// error_log(print_r($myArray, TRUE)); 
    	$templateMgr->assign(array('myCustomData'=> 'This data comes from DefaultChildThemePlugin.inc.php',
    		'myArray' => $myArray));
    }
  }
}

?>
