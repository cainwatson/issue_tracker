<template>
  <article v-if="loading" uk-spinner />
  <section v-else>
    <h1 class="uk-margin-medium-bottom">Projects</h1>
    <project-list :projects="projects">
      <template v-slot:emptyProjectsMessage>
        <p>
          It looks like you don't have any projects.
          <router-link to="/projects/new">Create a new project.</router-link>
        </p>
      </template>
    </project-list>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useStore } from 'vuex'
import { useResult } from '@vue/apollo-composable'
import { useUserProjectsQuery } from '../generated/graphql'
import { AppState } from '../store'
import ProjectList from '../components/ProjectList.vue'

export default defineComponent({
  name: 'MyProjects',
  components: {
    ProjectList,
  },
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
