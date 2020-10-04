<template>
  <main>
    <article class="uk-position-cover" v-if="loadingSignIn">
      <div class="uk-position-center">
        <div uk-spinner="ratio: 3"></div>
        <p class="uk-text-center">Loading...</p>
      </div>
    </article>
    <div v-else class="uk-flex">
      <router-view name="sidebar" />
      <div class="uk-width-expand	uk-padding">
        <router-view />
      </div>
    </div>
  </main>
</template>

<script lang="ts">
import { defineComponent, onMounted } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { AppState } from './store'
import { useTokenSignInMutation } from './generated/graphql'

export default defineComponent({
  name: 'App',
  setup() {
    const store = useStore<AppState>()
    const router = useRouter()

    const {
      loading: loadingSignIn,
      mutate: tokenSignInMutation,
      onDone: handleTokenSignInSuccess,
    } = useTokenSignInMutation({})

    onMounted(() => {
      const { jwt } = store.state.account

      if (jwt) {
        tokenSignInMutation({
          fields: { token: jwt },
        })
      }
    })

    handleTokenSignInSuccess(response => {
      const signInPayload = response?.data?.tokenSignIn

      if (signInPayload?.errors) {
        console.error(signInPayload)
        store.commit('account/signOut')
        return
      }

      store.commit('account/signIn', {
        jwt: signInPayload?.token,
        user: signInPayload?.user,
      })

      const { path, query } = router.currentRoute.value
      if (path === '/signin' && query.redirect) {
        router.replace(query.redirect as string)
      }
    })

    return {
      loadingSignIn,
    }
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
