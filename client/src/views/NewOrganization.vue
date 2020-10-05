<template>
  <section>
    <h1>New Organization</h1>
    <form @submit.prevent="handleSubmit">
      <ul v-if="errors.length > 0">
        <li v-for="error in errors" :key="error">
          {{ error }}
        </li>
      </ul>

      <div class="uk-margin">
        <label class="uk-form-label" for="create-organization-name">
          Name:
        </label>
        <input
          type="name"
          v-model="createOrganizationFields.name"
          class="uk-input"
          id="create-organization-name"
        />
      </div>

      <div class="uk-margin">
        <button
          type="submit"
          :disabled="loading"
          class="uk-button uk-button-primary"
        >
          Create Organization
        </button>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import { useCreateOrganizationMutation } from '../generated/graphql'
import { AppState } from '../store'

export default defineComponent({
  name: 'NewOrganization',
  setup() {
    const store = useStore<AppState>()
    const router = useRouter()
    const createOrganizationFields = reactive({
      name: '',
      userCreatorId: store.state.account.user?.id || '',
    })
    const errors = ref<string[]>([])
    const {
      loading,
      mutate: createOrganizationMutation,
      onDone: handleSuccess,
    } = useCreateOrganizationMutation({})

    const handleSubmit = () => {
      createOrganizationMutation({
        fields: createOrganizationFields,
      })
    }

    handleSuccess(response => {
      const payload = response?.data?.createOrganization

      if (payload?.errors) {
        errors.value = payload?.errors
        return
      }

      errors.value = []

      router.push(`/organizations/${payload?.organization?.id}`)
    })

    return {
      errors,
      loading,
      createOrganizationFields,
      handleSubmit,
    }
  },
})
</script>
