<template>
  <section>
    <h1>{{ project.name }}</h1>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useQuery, useResult } from '@vue/apollo-composable'
import gql from 'graphql-tag'

export default defineComponent({
  name: 'MyProjects',
  setup() {
    const route = useRoute()
    const { result, loading } = useQuery(
      gql`
        query getProject($projectId: ID!) {
          node(id: $projectId) {
            ... on Project {
              id
              name
            }
          }
        }
      `,
      { projectId: route.params.projectId },
    )
    const project = useResult(result, [], data => data.node)

    return {
      loading,
      project,
    }
  },
})
</script>
