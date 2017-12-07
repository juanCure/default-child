{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}
<div class="page page_search">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="common.search"}

	{* Results pagination *}
	{if !$results->wasEmpty()}
		<div class="my_cmp_pagination">
			{if $query}
				<label>{translate key="search.your.search"} "{$query}" {translate key="search.returned"} {$results->count} {translate key="search.results"}</label>
			{elseif $authors}
				<label>{translate key="search.your.search"} "{$authors}" {translate key="search.returned"} {$results->count} {translate key="search.results"}</label>
			{/if}
			<!-- {page_info iterator=$results} -->
			{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
		</div>
	{/if}

	{* Search results, finally! *}
	<div class="search_results">
		{iterate from=results item=result}
			{include file="frontend/objects/article_summary.tpl" article=$result.publishedArticle journal=$result.journal showDatePublished=true hideGalleys=true}
		{/iterate}
	</div>

	{* No results found *}
	{if $results->wasEmpty()}
		{if $error}
			{include file="frontend/components/notification.tpl" type="error" message=$error|escape}
		{else}
			{include file="frontend/components/notification.tpl" type="notice" messageKey="search.noResults"}
		{/if}

	{* Results pagination *}
	{else}
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
