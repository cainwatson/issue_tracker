<template>
  <div v-if="loading" uk-spinner></div>
  <section v-else>
    <h1>{{ project.name }}</h1>
    <issue-list :issues="project.issues" />
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useResult } from '@vue/apollo-composable'
import { useGetProjectQuery } from '../generated/graphql'
import IssueList from './Project/IssueList.vue'

export default defineComponent({
  name: 'Project',
  components: {
    IssueList,
  },
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
