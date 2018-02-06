{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

	</div><!-- pkp_structure_main -->
	
	{* Sidebars *}
	{if empty($isFullWidth)}
		{call_hook|assign:"sidebarCode" name="Templates::Common::Sidebar"}
		{if $sidebarCode}
			<div class="pkp_structure_sidebar left" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
				{if $requestedPage != 'article' && $requestedPage != 'search' && $requestedPage != 'about'}
					<!-- Agregando un div con video -->
					<div class="pkp_block">
						<span class="title">Videos</span>
						<div class="content">
							<p><iframe width="320" height="315" src="https://www.youtube.com/embed/3rmjoOQpRwE" frameborder="0" allowfullscreen></iframe></p>
						</div>
					</div>
					<!-- Agregando un div para contener el iframe con la página de facebook de la revista -->
					<div class="pkp_block">
						<iframe src="https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2Frevista.perfiles.educativos%2F&tabs=timeline&width=340&height=500&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=1512284222119075" width="320" height="500" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>
					</div>
				{* Article Page*}
				{elseif $issue && $section && $myPublishedArticles}
					<div class="my_block_title">
						<h3>{translate key="plugins.themes.default-child.related.articles.heading"}</h3>
					</div>
					<div class="myPublishedArticles pkp_block">
						{foreach name=sections from=$myPublishedArticles item=section}
							{if $section.articles}
								<div class="myArticles">
									{foreach from=$section.articles item=article}
										{assign var=articlePath value=$article->getBestArticleId()}
										<div class="title">
											<a {if $journal}href="{url journal=$journal->getPath() page="article" op="view" path=$articlePath}"{else}href="{url page="article" op="view" path=$articlePath}"{/if}>
											{$article->getLocalizedTitle()|strip_unsafe_html}
											</a>
										</div>
										<div class="authors">
											{$article->getAuthorString()}
										</div>
									{/foreach}
								</div>
							{/if}
						{/foreach}
					</div>
				{* Search Page *}
				{elseif $requestedPage == 'search'}
					<div class="my_search_section">
						<form class="cmp_form" method="post" action="{url op="search"}">
							{csrf}

							{* Repeat the label text just so that screen readers have a clear label/input relationship *}
							<!-- <div class="search_input">
								<label class="pkp_screen_reader" for="query">
									{translate key="search.searchFor"}
								</label>
								<input type="text" id="query" name="query" value="{$query|escape}" class="query" placeholder="{translate|escape key="common.search"}">
							</div> -->

							<fieldset class="search_advanced">
								<legend>
									{translate key="search.advancedFilters"}
								</legend>
								<div class="my_block">
									<span>Filtar por fechas:</span>
									<div class="date_range">
										<div class="from">
											<label class="label">
												{translate key="search.dateFrom"}
											</label>
											{html_select_date prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
										</div>
										<div class="to">
											<label class="label">
												{translate key="search.dateTo"}
											</label>
											{html_select_date prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="" month_empty="" day_empty="" field_order="YMD"}
										</div>
									</div>
								</div>
								<br>
								<div class="my_block">
									<span>Buscar por:</span>
									<div class="author">
										<label class="label" for="authors">
											{translate key="search.author"}
										</label>
										<input type="text" for="authors" name="authors" value="{$authors}">
									</div>
								</div>
							</fieldset>

							<div class="submit">
								<button class="submit" type="submit">{translate key="common.search"}</button>
							</div>
						</form>
					</div>
					{* Página about *}
					{elseif $requestedPage == 'about' && $requestedOp == 'index'}
					<div class="pkp_block" id="fixed_anchors">
						<span class="title">Contenidos</span>
						<div class="content">
							<ul>
								<li><a href="#enfoque">Enfoque y alcance</a></li>
								<li><a href="#peerReviewProcess">Proceso de evaluación por pares</a></li>
								<li><a href="#openAccessPolicy">Política de acceso abierto</a></li>
								<li><a href="#ethicsCode">Código ética</a></li>
								<li><a href="#databases">Índices, catálogos y bases de datos</a></li>
								<li><a href="#history">Historial de la revista</a></li>
							</ul>
						</div>
					</div>
				{/if}
				{$sidebarCode}
			</div><!-- pkp_sidebar.left -->
		{/if}
	{/if}
</div><!-- pkp_structure_content -->

<div id="pkp_content_footer" class="pkp_structure_footer_wrapper" role="contentinfo">

	<div class="pkp_structure_footer">
		{if $pageFooter}
			<div class="pkp_footer_content">
				<div class="my_footer_content">
					<div class="left_content">
						{$pageFooter}
					</div>
					<div id="right_content">
					</div>
				</div>
			</div>
		{/if}
		{*
		<div class="pkp_brand_footer" role="complementary">
			<a href="{url page="about" op="aboutThisPublishingSystem"}">
				<img alt="{translate key="about.aboutThisPublishingSystem"}" src="{$baseUrl}/{$brandImage}">
			</a>
		</div>*}
	</div>
</div><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
