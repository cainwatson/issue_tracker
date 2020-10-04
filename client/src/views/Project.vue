<template>
  <div v-if="loading" uk-spinner></div>
  <section v-else>
    <h1>{{ project.name }}</h1>
    <ul uk-tab>
      <li class="uk-active">
        <router-link :to="`/projects/${project.id}/backlog`">
          Backlog
        </router-link>
      </li>
      <li>
        <a href="#">
          Boards
          <span
            class="uk-margin-small-left"
            uk-icon="icon: triangle-down"
          ></span>
        </a>
        <div uk-dropdown="mode: click">
          <ul class="uk-nav uk-dropdown-nav">
            <li v-for="board in project.boards" :key="board.id">
              <router-link :to="`/projects/${project.id}/boards/${board.id}`">
                {{ board.name }}
              </router-link>
            </li>
          </ul>
        </div>
      </li>
    </ul>
    <router-view />
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import { useResult } from '@vue/apollo-composable'
import { useGetProjectQuery } from '../generated/graphql'

export default defineComponent({
  name: 'Project',
  props: {
    projectId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectQuery({
      projectId: props.projectId || '',
    })
    const project = useResult(result, [], data => data.node)

    return {
      loading,
      project,
    }
  },
})
</script>
