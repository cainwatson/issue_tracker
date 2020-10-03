<template>
  <section>
    <h1>Organizations</h1>
    <div v-if="loading" uk-spinner></div>
    <p v-if="!loading && organizations.length === 0">
      It looks like you aren't apart of any organizations.
    </p>
    <ul
      v-if="organizations"
      class="uk-child-width-1-2@m uk-child-width-1-3@l"
      uk-grid
    >
      <li v-for="organization in organizations" :key="organization.id">
        <router-link
          :to="`/organizations/${organization.id}`"
          class="uk-link-toggle uk-link-reset"
        >
          <article class="uk-card uk-card-default uk-card-muted">
            <div class="uk-padding-small">
              <img
                :src="organization.photoUrl"
                :alt="`${organization.name}'s avatar`"
              />
            </div>
            <div class="uk-card-body">
              <h1 class="uk-card-title">{{ organization.name }}</h1>
            </div>
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
import { useUserOrganizationsQuery } from '../generated/graphql'
import { AppState } from '../store'

export default defineComponent({
  name: 'MyOrganizations',
  setup() {
    const store = useStore<AppState>()
    const { result, loading } = useUserOrganizationsQuery({
      userId: store.state.account.user?.id || '',
    })
    const organizations = useResult(result, [], data => {
      if (data.node?.__typename === 'User') {
        return data.node.memberships.map(membership => membership.organization)
      }
      return []
    })

    return {
      loading,
      organizations,
    }
  },
})
</script>
