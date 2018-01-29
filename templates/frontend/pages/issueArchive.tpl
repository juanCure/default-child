{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of recent issues.
 *
 * @uses $issues Array Collection of issues to display
 *}
{capture assign="pageTitle"}
	{if $issues->getPageCount() > 0 && $issues->getPage() > 1}
		{translate key="archive.archivesPageNumber" pageNumber=$issues->getPage()}
	{else}
		{translate key="archive.archives"}
	{/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}
<div class="page page_issue_archive">
	{include file="frontend/components/breadcrumbs.tpl" currentTitle=$pageTitle}
	{* No issues have been published *}
	{if $issues->wasEmpty()}
		<p>{translate key="current.noCurrentIssueDesc"}</p>

	{* List issues *}
	{else}
		<div class="years">
			{foreach name=years from=$yearsArray item=year}
				<div class="year">
					<h2 class="acc-header active">
						{$year.year} | {$year.total_elements} {translate key="plugins.themes.default-child.issues"}.
					</h2>
					<div class="acc-body">
						<ul class="my_issues">
							{foreach name=issues from=$year.elements item=issue}
								<li>
									{include file="frontend/objects/issue_summary.tpl"}
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
			{/foreach}
		</div>
		{*<ul class="issues_archive">
			{assign var=index value=0}
			{iterate from=issues item=issue}
				{if $issue->getDatePublished()|date_format:"%Y" != $lastPublishedYear}
					<li><h2 class="acc-header">{$issue->getDatePublished()|date_format:"%Y"|escape} |  {$yearsArray[$index].total_elements} {translate key="plugins.themes.default-child.issues"}</h2></li>
					{assign var=lastPublishedYear value=$issue->getDatePublished()|date_format:"%Y"}
					{assign var=index value=$index+1}
				{/if}
				<li>
					{include file="frontend/objects/issue_summary.tpl"}
				</li>
			{/iterate}
		</ul>*}

		{if $issues->getPageCount() > 0}
			<div class="cmp_pagination">
				{page_info iterator=$issues}
				{page_links anchor="issues" name="issues" iterator=$issues}
			</div>
		{/if}
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
