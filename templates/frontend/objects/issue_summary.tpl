{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2017 Simon Fraser University
 * Copyright (c) 2003-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{if $issue->getShowTitle()}
{assign var=issueTitle value=$issue->getLocalizedTitle()}
{/if}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueCover value=$issue->getLocalizedCoverImageUrl()}
{* Obteniendo la fecha de publicación del número*}
{assign var=myPublishedDate value=$issue->getDatePublished()}
{assign var=issueYear value=$issue->getYear()}
<div class="obj_issue_summary">
	{*
	{if $issueCover}
		<a class="cover" href="{url op="view" path=$issue->getBestIssueId()}">
			<img src="{$issueCover|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
		</a>
	{/if}
	*}
	<a class="title" href="{url op="view" path=$issue->getBestIssueId()}">
		{if $issueTitle}
			{$issueTitle|escape}, {$myPublishedDate|date_format}
		{else}
			{$issueSeries|escape}, {$myPublishedDate|date_format}
		{/if}
	</a>
	{if $issueTitle && $issueSeries}
		<div class="series">
			{$issueSeries|escape}
		</div>
	{/if}

	<div class="description">
		{$issue->getLocalizedDescription()|strip_unsafe_html}
	</div>
</div><!-- .obj_issue_summary -->
