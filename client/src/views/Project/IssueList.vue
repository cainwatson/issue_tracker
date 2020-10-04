<template>
  <section
    uk-accordion
    multiple
    targets="ul > *"
    toggle="> article > .uk-accordion-title"
    content="> article > .uk-accordion-content"
  >
    <ul v-if="issues.length > 0" class="uk-list uuk-list-large uk-list-striped">
      <li v-for="issue in issues" :key="issue.id">
        <article>
          <a class="uk-accordion-title uk-flex" href="#">
            <span class="uk-margin-small-right">{{ issue.number }}</span>
            <p class="uk-margin-remove">
              {{ issue.summary }}
            </p>
          </a>
          <p class="uk-accordion-content uk-margin-remove-bottom">
            {{ issue.description }}
          </p>
        </article>
      </li>
    </ul>
  </section>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { Issue } from '../../generated/graphql'

export default defineComponent({
  name: 'IssueList',
  props: {
    issues: {
      type: Array as PropType<Issue[]>,
      required: true,
    },
  },
})
</script>
