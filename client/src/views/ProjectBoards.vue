<template>
  <div v-if="loading" uk-spinner></div>
  <section v-else>
    <ul v-if="boards.length > 0" class="uk-list uuk-list-large uk-list-striped">
      <li v-for="board in boards" :key="board.id">
        <article>
          <p>{{ board.name }}</p>
        </article>
      </li>
    </ul>
  </section>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent } from 'vue'
import { useGetProjectBoardsQuery } from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBoards',
  props: {
    projectId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectBoardsQuery({
      projectId: props.projectId || '',
    })
    const boards = useResult(result, [], data => {
      if (data.node?.__typename === 'Project') {
        return data.node.boards
      }
    })

    return {
      loading,
      boards,
    }
  },
})
</script>
