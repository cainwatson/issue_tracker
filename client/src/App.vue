<template>
  <main>
    <side-bar-layout>
      <router-view></router-view>
    </side-bar-layout>
  </main>
</template>

<script lang="ts">
import { useStore } from 'vuex'
import { defineComponent, onMounted } from 'vue'
import { AppState } from './store'
import { useTokenSignInMutation } from './generated/graphql'
import SideBarLayout from './components/SideBarLayout.vue'

export default defineComponent({
  name: 'App',
  components: {
    SideBarLayout,
  },
  setup() {
    const store = useStore<AppState>()

    const {
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

      store.commit('account/signIn', { jwt: store.state.account.jwt })
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
