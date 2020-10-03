<template>
  <main>
    <side-bar-layout>
      <router-view></router-view>
    </side-bar-layout>
  </main>
</template>

<script lang="ts">
import { defineComponent, reactive, watch } from 'vue'
import { useStore } from 'vuex'
import { useRoute, useRouter } from 'vue-router'
import { useMutation } from '@vue/apollo-composable'
import gql from 'graphql-tag'
import { AppState } from './store'
import SideBarLayout from './components/SideBarLayout.vue'

export default defineComponent({
  name: 'App',
  components: {
    SideBarLayout,
  },
  setup() {
    const router = useRouter()
    const route = useRoute()
    const store = useStore<AppState>()
    const account = reactive(store.state.account)

    const {
      mutate: tokenSignInMutation,
      onDone: handleTokenSignInSuccess,
    } = useMutation(gql`
      mutation tokenSignIn($tokenSignInFields: TokenSignInInput!) {
        tokenSignIn(input: $tokenSignInFields) {
          errors
          user {
            id
          }
        }
      }
    `)

    watch(
      account,
      ({ isLoggedIn, jwt }) => {
        if (!isLoggedIn && jwt) {
          tokenSignInMutation({
            tokenSignInFields: { token: jwt },
          })
        } else if (!isLoggedIn && route.meta.requiresAuth) {
          router.push('/signin')
        }
      },
      { immediate: true },
    )

    handleTokenSignInSuccess(response => {
      const signInPayload = response?.data?.tokenSignIn

      if (signInPayload?.errors) {
        console.error(signInPayload)
        store.commit('account/signOut')
        return
      }

      store.commit('account/signIn', { jwt: signInPayload.token })
    })

    router.beforeEach((to, from, next) => {
      if (!account.isLoggedIn && to.meta.requiresAuth) {
        return next({
          path: '/signin',
          query: {
            redirect: to.fullPath,
          },
        })
      }
      next()
    })

    return {}
  },
})
</script>

<style lang="scss">
// Custom variables and variable overwrites.
/* $global-link-color: #da7d02; */

@import 'uikit/src/scss/variables-theme.scss';
@import 'uikit/src/scss/mixins-theme.scss';

// Custom mixin overwrites.
/* @mixin hook-card() {
  color: #000;
} */

@import 'uikit/src/scss/uikit-theme.scss';
</style>
