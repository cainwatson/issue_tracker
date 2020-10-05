<template>
  <article v-if="loading" uk-spinner />
  <section v-else>
    <h1 class="uk-margin-medium-bottom">Organizations</h1>
    <p v-if="organizations.length === 0">
      It looks like you aren't apart of any organizations.
    </p>
    <ul
      v-else
      class="uk-child-width-1-2@m uk-child-width-1-3@l uk-grid-match"
      uk-grid
    >
      <li v-for="organization in organizations" :key="organization.id">
        <router-link
          :to="`/organizations/${organization.id}`"
          class="uk-link-toggle uk-link-reset"
        >
          <article class="uk-card uk-card-default uk-card-muted uk-height-1-1">
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
      <li>
        <router-link
          :to="`/organizations/new`"
          class="uk-link-toggle uk-link-reset"
        >
          <article class="uk-card uk-card-body uk-card-default uk-card-muted">
            <p class="uk-heading-medium uk-text-center">+</p>
            <h1 class="uk-card-title">New Organization</h1>
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
