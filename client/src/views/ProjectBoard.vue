<template>
  <article v-if="loading" uk-spinner />
  <div v-else uk-grid class="project-board uk-grid-small uk-flex-nowrap">
    <section
      v-for="column in board.columns"
      :key="column.id"
      class="uk-width-medium"
    >
      <div
        class="uk-width-medium uk-tile uk-tile-muted uk-padding-small uk-border-rounded"
      >
        <h3>{{ column.name }}</h3>
        <article
          v-for="item in column.items"
          :key="item.id"
          class="uk-card uk-card-body uk-card-default uk-card-small uk-margin-bottom"
        >
          <h5>{{ item.issue.summary }}</h5>
          <p>{{ item.issue.description }}</p>
        </article>
      </div>
    </section>
  </div>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent, watch } from 'vue'
import { useGetProjectBoardQuery } from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBoard',
  props: {
    projectId: String,
    boardId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectBoardQuery({
      projectId: props.projectId || '',
      boardId: props.boardId || '',
    })
    const board = useResult(result, null, data => {
      if (data.board?.__typename === 'Board') {
        return data.board
      }
    })

    watch(board, board => {
      if (board) {
        document.title = board.name
      }
    })

    return {
      loading,
      board,
    }
  },
})
</script>

<style lang="scss" scoped>
.project-board {
  overflow-x: scroll;
}
</style>
