<template>
  <section>
    <h1>Sign Up</h1>
    <form @submit.prevent="handleSubmit">
      <ul v-if="errors.length > 0">
        <li v-for="error in errors" :key="error">
          {{ error }}
        </li>
      </ul>

      <div class="uk-margin">
        <label class="uk-form-label" for="sign-up-email">Email:</label>
        <input
          type="email"
          v-model="signUpFields.email"
          class="uk-input"
          id="sign-up-email"
        />
      </div>

      <div class="uk-margin uk-grid-small" uk-grid>
        <div class="uk-width-1-2@s">
          <label class="uk-form-label" for="sign-up-password">Password:</label>
          <input
            type="password"
            v-model="signUpFields.password"
            class="uk-input"
            id="sign-up-password"
          />
        </div>
        <div class="uk-width-1-2@s">
          <label class="uk-form-label" for="sign-up-password-confirmation">
            Password Confirmation:
          </label>
          <input
            type="password"
            v-model="signUpFields.passwordConfirmation"
            class="uk-input"
            id="sign-up-password-confirmation"
          />
        </div>
      </div>

      <div class="uk-margin uk-grid-small" uk-grid>
        <div class="uk-width-1-2@s">
          <label class="uk-form-label" for="sign-up-first-name">
            First Name:
          </label>
          <input
            type="text"
            v-model="signUpFields.firstName"
            class="uk-input"
            id="sign-up-first-name"
          />
        </div>
        <div class="uk-width-1-2@s">
          <label class="uk-form-label" for="sign-up-last-name">
            Last Name:
          </label>
          <input
            type="text"
            v-model="signUpFields.lastName"
            class="uk-input"
            id="sign-up-last-name"
          />
        </div>
      </div>

      <div class="uk-margin">
        <button
          type="submit"
          :disabled="loading"
          class="uk-button uk-button-primary"
        >
          Create Account
        </button>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { useSignUpMutation } from '../generated/graphql'
import { AppState } from '../store'

const defaultFieldValues = {
  email: '',
  password: '',
  passwordConfirmation: '',
  firstName: '',
  lastName: '',
}

export default defineComponent({
  name: 'SignUp',
  setup() {
    const store = useStore<AppState>()
    const router = useRouter()
    const signUpFields = reactive({ ...defaultFieldValues })
    const errors = ref<string[]>([])
    const {
      loading,
      mutate: signUpMutation,
      onDone: handleSuccess,
    } = useSignUpMutation({})

    const handleSubmit = () => {
      const {
        email,
        password,
        passwordConfirmation,
        firstName,
        lastName,
      } = signUpFields

      if (password !== passwordConfirmation) {
        errors.value.push('Password confirmation does not match password.')
        return
      }

      signUpMutation({
        fields: { email, password, firstName, lastName },
      })
    }

    handleSuccess(response => {
      const signUpPayload = response?.data?.signUp

      if (signUpPayload?.errors) {
        errors.value = signUpPayload?.errors
        return
      }

      errors.value = []

      store.commit('account/signIn', { jwt: signUpPayload?.token })
      router.push('/dashboard')
    })

    return {
      errors,
      loading,
      signUpFields,
      handleSubmit,
    }
  },
})
</script>
