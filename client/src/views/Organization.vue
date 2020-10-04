<template>
  <section>
    <h1>{{ organization.name }}</h1>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useResult } from '@vue/apollo-composable'
import { useGetOrganizationQuery } from '../generated/graphql'

export default defineComponent({
  name: 'Organization',
  props: {
    organizationId: String,
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
