<template>
  <section>
    <article v-if="redirect" class="uk-alert-warning" uk-alert>
      <a class="uk-alert-close" uk-close></a>
      <p>You must sign in to access that page.</p>
    </article>

    <h1>Sign In</h1>
    <form @submit.prevent="handleSubmit">
      <ul v-if="errors.length > 0">
        <li v-for="error in errors" :key="error">
          {{ error }}
        </li>
      </ul>

      <div class="uk-margin">
        <label class="uk-form-label" for="sign-in-email">Email:</label>
        <input
          type="email"
          v-model="signInFields.email"
          class="uk-input"
          id="sign-in-email"
        />
      </div>

      <div class="uk-margin">
        <label class="uk-form-label" for="sign-in-password">Password:</label>
        <input
          type="password"
          v-model="signInFields.password"
          class="uk-input"
          id="sign-in-password"
        />
      </div>

      <div class="uk-margin">
        <button
          type="submit"
          :disabled="loading"
          class="uk-button uk-button-primary"
        >
          Sign In
        </button>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import { defineComponent, ref, reactive, computed } from 'vue'
import { useStore } from 'vuex'
import { useRouter, useRoute } from 'vue-router'
import { usePasswordSignInMutation } from '../generated/graphql'
import { AppState } from '../store'

export default defineComponent({
  name: 'SignIn',
  setup() {
    const store = useStore<AppState>()
    const router = useRouter()
    const route = useRoute()
    const redirect = computed(() => route.query.redirect as string)
    const signInFields = reactive({
      email: '',
      password: '',
    })
    const errors = ref<string[]>([])
    const {
      loading,
      mutate: signInMutation,
      onDone: handleSuccess,
    } = usePasswordSignInMutation({})

    const handleSubmit = () => {
      signInMutation({
        fields: signInFields,
      })
    }

    handleSuccess(response => {
      const signInPayload = response?.data?.passwordSignIn

      if (signInPayload?.errors) {
        errors.value = signInPayload?.errors
        return
      }

      errors.value = []

      store.commit('account/signIn', {
        jwt: signInPayload?.token,
        user: signInPayload?.user,
      })
      router.push(redirect.value || '/dashboard')
    })

    return {
      errors,
      loading,
      signInFields,
      handleSubmit,
      redirect,
    }
  },
})
</script>
