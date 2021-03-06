{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

	<div class="cmp_skip_to_content">
		<a href="#pkp_content_main">{translate key="navigation.skip.main"}</a>
		<a href="#pkp_content_nav">{translate key="navigation.skip.nav"}</a>
		<a href="#pkp_content_footer">{translate key="navigation.skip.footer"}</a>
	</div>
	<div class="pkp_structure_page">

		{* Header *}
		<header class="pkp_structure_head" id="headerNavigationContainer" role="banner">
			<div class="pkp_head_wrapper">

				<div class="pkp_site_name_wrapper">
					{* Logo or site title. Only use <h1> heading on the homepage.
					   Otherwise that should go to the page title. *}
					{if $requestedOp == 'index'}
						<h1 class="pkp_site_name">
					{else}
						<div class="pkp_site_name">
					{/if}
						{if $currentContext && $multipleContexts}
							{url|assign:"homeUrl" journal="index" router=$smarty.const.ROUTE_PAGE}
						{else}
							{url|assign:"homeUrl" page="index" router=$smarty.const.ROUTE_PAGE}
						{/if}
						{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
							</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="is_text">{$displayPageHeaderTitle}</a>
						{elseif $displayPageHeaderTitle && !$displayPageHeaderLogo && is_array($displayPageHeaderTitle)}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" alt="{$displayPageHeaderTitle.altText|escape}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" />
							</a>
						{else}
							<a href="{$homeUrl}" class="is_img">
								<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" width="180" height="90" />
							</a>
						{/if}
					{if $requestedOp == 'index'}
						</h1>
					{else}
						</div>
					{/if}
				</div>

			</div><!-- .pkp_head_wrapper -->
		</header><!-- .pkp_structure_head -->

		<!-- Definiendo el banner y enseguida el menú principal -->

		{* Agregando un banner *}
		<div class="mi_banner">
			<!-- <p>Aquí deberá venir un banner </p> -->
			<img src="{$baseUrl}/plugins/themes/default-child/images/banner-perfiles-educativos.jpg" width="100%" />
		</div>

		{* Primary site navigation *}
		<div class="mi_menu">
			{if $currentContext}
				<nav class="pkp_navigation_primary_row" aria-label="{translate|escape key="common.navigation.site"}">
					<div class="pkp_navigation_primary_wrapper">
						{* Primary navigation menu for current application *}
						{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}

						{* Cargando el menú hamburguesa *}
						<div id="hamburguesa">
							<span class="icon-menu"> </span>
							<ul id="menuPhone" class="pkp_navigation_primary pkp_nav_list">
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/index">
										Inicio
									</a>
								</li>
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/about">
										Acerca de
									</a>
								</li>
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/issue/archive">
										Números anteriores
									</a>
								</li>
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/about/submissions">
										Autores
									</a>
								</li>
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/announcement">
										Avisos
									</a>
								</li>
								<li class="">
									<a href="http://perfileseducativos.unam.mx/iisue_pe/index.php/perfiles/
									sitiosinteres">
									Sitios de interés
									</a>
								</li>
							</ul>
						</div>
						{* Search form *}
						{include file="frontend/components/searchForm_simple.tpl"}
					</div>
				</nav>
			{/if}
			<nav class="pkp_navigation_user_wrapper" id="navigationUserWrapper" aria-label="{translate|escape key="common.navigation.user"}">
				{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
			</nav>
		</div>

		{* Wrapper for page content and sidebars *}
		{if $isFullWidth}
			{assign var=hasSidebar value=0}
		{/if}
		<div class="pkp_structure_content{if $hasSidebar} has_sidebar{/if}">
			<div id="pkp_content_main" class="pkp_structure_main" role="main">
