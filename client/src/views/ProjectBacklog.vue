<template>
  <article v-if="loading" uk-spinner />
  <section v-else>
    <p v-if="issues.length === 0">No issues found.</p>
    <div
      v-else
      uk-accordion
      multiple
      targets="ul > *"
      toggle="> article > .uk-accordion-title"
      content="> article > .uk-accordion-content"
    >
      <ul class="uk-list uk-list-striped">
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
    </div>
  </section>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { computed, defineComponent, watch } from 'vue'
import { useGetProjectIssuesQuery } from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBacklog',
  props: {
    projectId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectIssuesQuery({
      projectId: props.projectId || '',
    })
    const project = useResult(result, null, data => {
      if (data.node?.__typename === 'Project') {
        return data.node
      }
    })
    const issues = computed(() => project.value && project.value.issues)

    watch(project, project => {
      if (project) {
        document.title = `${project.name} | Backlog`
      }
    })

    return {
      loading,
      issues,
    }
  },
})
</script>
