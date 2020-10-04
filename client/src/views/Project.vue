<template>
  <div v-if="loading" uk-spinner></div>
  <section v-else>
    <h1>{{ project.name }}</h1>
    <ul uk-tab>
      <li class="uk-active">
        <router-link
          :to="`/projects/${project.id}/backlog`"
          class="uuk-link-toggle uuk-link-reset"
        >
          Backlog
        </router-link>
      </li>
      <li>
        <router-link
          :to="`/projects/${project.id}/boards`"
          class="uuk-link-toggle uuk-link-reset"
        >
          Boards
        </router-link>
      </li>
    </ul>
    <router-view />
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useResult } from '@vue/apollo-composable'
import { useGetProjectQuery } from '../generated/graphql'

export default defineComponent({
  name: 'Project',
  props: {
    projectId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectQuery({
      projectId: props.projectId || '',
    })
    const project = useResult(result, [], data => data.node)

    return {
      loading,
      project,
    }
  },
})
</script>
