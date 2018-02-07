{**
 * templates/frontend/components/searchForm_simple.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Simple display of a search form with just text input and search button
 *
 * @uses $searchQuery string Previously input search query
 *}
{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	<form class="pkp_search" action="{url page="search" op="search"}" method="post" role="search">
		<div class="box">
		  <div class="container-2">
		      <span class="icon">
		      	<a href="{url page="search" op="search"}" class="headerSearchPrompt search_prompt" aria-hidden="true">
							<i class="fa fa-search"></i>
						</a>
					</span>
					{csrf}
		      <input id="search" name="query" value="{$searchQuery|escape}" type="search" aria-label="{translate|escape key="common.searchQuery"}">
		  </div>
		</div>
</form>
{/if}
