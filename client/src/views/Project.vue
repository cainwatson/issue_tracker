<template>
  <section>
    <h1>{{ project.name }}</h1>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useResult } from '@vue/apollo-composable'
import { useGetProjectQuery } from '../generated/graphql'

export default defineComponent({
  name: 'Project',
  setup() {
    const route = useRoute()
    const { result, loading } = useGetProjectQuery({
      projectId: route.params.projectId as string,
    })
    const project = useResult(result, [], data => data.node)

    return {
      loading,
      project,
    }
  },
})
</script>
