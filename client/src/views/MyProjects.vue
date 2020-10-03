<template>
  <section>
    <h1>Projects</h1>
    <div v-if="loading" uk-spinner></div>
    <p v-if="!loading && projects.length === 0">
      It looks like you don't have any projects.
    </p>
    <ul
      v-if="projects"
      class="uk-child-width-1-2@m uk-child-width-1-3@l"
      uk-grid
    >
      <li v-for="project in projects" :key="project.id">
        <router-link
          :to="`/projects/${project.id}`"
          class="uk-link-toggle uk-link-reset"
        >
          <article class="uk-card uk-card-default uk-card-body uk-card-muted">
            <h1 class="uk-text-large">{{ project.name }}</h1>
          </article>
        </router-link>
      </li>
    </ul>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore } from 'vuex'
import { useResult } from '@vue/apollo-composable'
import { useUserProjectsQuery } from '../generated/graphql'
import { AppState } from '../store'

export default defineComponent({
  name: 'MyProjects',
  setup() {
    const store = useStore<AppState>()
    const { result, loading } = useUserProjectsQuery({
      userId: store.state.account.user?.id || '',
    })
    const projects = useResult(result, [], data => {
      if (data.node?.__typename === 'User') {
        return data.node.projects
      }
      return []
    })

    return {
      loading,
      projects,
    }
  },
})
</script>
