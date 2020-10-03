<template>
  <section>
    <h1>{{ organization.name }}</h1>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import { useResult } from '@vue/apollo-composable'
import { useGetOrganizationQuery } from '../generated/graphql'

export default defineComponent({
  name: 'Organizations',
  setup() {
    const route = useRoute()
    const { result, loading } = useGetOrganizationQuery({
      organizationId: route.params.organizationId as string,
    })
    const organization = useResult(result, [], data => data.node)

    return {
      loading,
      organization,
    }
  },
})
</script>
