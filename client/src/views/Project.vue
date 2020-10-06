<template>
  <article v-if="loading" uk-spinner />
  <section v-else-if="project">
    <h1 class="uk-margin-medium-bottom">{{ project.name }}</h1>
    <ul uk-tab>
      <li :class="{ 'uk-active': isActiveTab(Tab.Backlog) }">
        <router-link :to="`/projects/${project.id}/backlog`">
          Backlog
        </router-link>
      </li>
      <li :class="{ 'uk-active': isActiveTab(Tab.Boards) }">
        <a href="#">
          Boards
          <span class="uk-margin-small-left" uk-icon="icon: triangle-down" />
        </a>
        <div uk-dropdown="mode: click">
          <p v-if="project.boards.length === 0" class="uk-margin-remove">
            No boards have been created.
          </p>
          <ul v-else class="uk-nav uk-dropdown-nav">
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
import { useRoute } from 'vue-router'
import { useResult } from '@vue/apollo-composable'
import { useGetProjectQuery } from '../generated/graphql'

enum Tab {
  Backlog = '/backlog',
  Boards = '/boards',
}

export default defineComponent({
  name: 'Project',
  props: {
    projectId: String,
  },
  setup(props) {
    const route = useRoute()
    const { result, loading } = useGetProjectQuery({
      projectId: props.projectId || '',
    })
    const project = useResult(result, null, data => data.node)

    const isActiveTab = (tab: Tab) => route.path.includes(tab)

    return {
      loading,
      project,
      isActiveTab,
      Tab,
    }
  },
})
</script>
