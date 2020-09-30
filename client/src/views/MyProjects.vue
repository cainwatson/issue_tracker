<template>
  <section>
    <h1>Projects</h1>
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
import { useQuery, useResult } from '@vue/apollo-composable'
import gql from 'graphql-tag'

export default defineComponent({
  name: 'MyProjects',
  setup() {
    const { result, loading } = useQuery(gql`
      query {
        users {
          projects {
            id
            name
          }
        }
      }
    `)
    const projects = useResult(result, [], data => data.users[0].projects)

    return {
      loading,
      projects,
    }
  },
})
</script>
