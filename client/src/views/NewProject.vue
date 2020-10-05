<template>
  <section>
    <h1>New Project</h1>
    <form @submit.prevent="handleSubmit">
      <ul v-if="errors.length > 0">
        <li v-for="error in errors" :key="error">
          {{ error }}
        </li>
      </ul>

      <div class="uk-margin">
        <label class="uk-form-label" for="create-project-name">
          Name:
        </label>
        <input
          type="name"
          v-model="createProjectFields.name"
          class="uk-input"
          id="create-project-name"
        />
      </div>

      <div class="uk-margin">
        <button
          type="submit"
          :disabled="loading"
          class="uk-button uk-button-primary"
        >
          Create Project
        </button>
      </div>
    </form>
  </section>
</template>

<script lang="ts">
import { defineComponent, ref, reactive } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import {
  ProjectOwnerCategory,
  useCreateProjectMutation,
} from '../generated/graphql'
import { AppState } from '../store'

export default defineComponent({
  name: 'NewProject',
  setup() {
    const store = useStore<AppState>()
    const router = useRouter()
    const createProjectFields = reactive({
      name: '',
      ownerType: ProjectOwnerCategory.Account,
      ownerId: store.state?.account?.user?.id || '',
      userCreatorId: store.state?.account?.user?.id || '',
    })
    const errors = ref<string[]>([])
    const {
      loading,
      mutate: createProjectMutation,
      onDone: handleSuccess,
    } = useCreateProjectMutation({})

    const handleSubmit = () => {
      createProjectMutation({
        fields: createProjectFields,
      })
    }

    handleSuccess(response => {
      const payload = response?.data?.createProject

      if (payload?.errors) {
        errors.value = payload?.errors
        return
      }

      errors.value = []

      router.push(`/projects/${payload?.project?.id}`)
    })

    return {
      errors,
      loading,
      createProjectFields,
      handleSubmit,
    }
  },
})
</script>
