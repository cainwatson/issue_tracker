<template>
  <article v-if="loading" uk-spinner />
  <section v-else>
    <h1 class="uk-margin-medium-bottom">{{ organization.name }}</h1>
    <article>
      <h2>Projects</h2>
      <project-list
        :projects="organization.projects"
        emptyProjectsMessage="This organization hasn't created any projects."
      />
    </article>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useResult } from '@vue/apollo-composable'
import { useGetOrganizationQuery } from '../generated/graphql'
import ProjectList from '../components/ProjectList.vue'

export default defineComponent({
  name: 'Organization',
  props: {
    organizationId: String,
  },
  components: {
    ProjectList,
  },
  setup(props) {
    const { result, loading } = useGetOrganizationQuery({
      organizationId: props.organizationId || '',
    })
    const organization = useResult(result, [], data => data.node)

    return {
      loading,
      organization,
    }
  },
})
</script>
