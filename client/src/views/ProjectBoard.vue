<template>
  <article v-if="loading" uk-spinner />
  <div
    v-else-if="board"
    uk-grid
    class="project-board uk-grid-small uk-flex-nowrap"
  >
    <board-column
      v-for="column in board.columns"
      :key="column.id"
      :column="column"
      :handleIssueDrag="handleIssueDrag"
    />
  </div>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent, watch } from 'vue'
import {
  useGetProjectBoardQuery,
  useMoveBoardItemMutation,
} from '../generated/graphql'
import BoardColumn from './ProjectBoard/BoardColumn.vue'

export default defineComponent({
  name: 'ProjectBoard',
  components: {
    BoardColumn,
  },
  props: {
    boardId: String,
  },
  setup(props) {
    const { result, loading, refetch: refetchBoard } = useGetProjectBoardQuery({
      boardId: props.boardId || '',
    })
    const board = useResult(result, null, data => {
      if (data.node?.__typename === 'Board') {
        return data.node
      }
    })
    const {
      loading: saving,
      mutate: moveBoardItemMutation,
    } = useMoveBoardItemMutation({})

    const handleIssueDrag = event => {
      if (event.moved) {
        const { element, newIndex } = event.moved

        moveBoardItemMutation(
          {
            input: {
              itemId: element.id,
              position: newIndex,
            },
          },
          { awaitRefetchQueries: true },
        )
        refetchBoard()
      }
    }

    watch(board, board => {
      if (board) {
        document.title = board.name
      }
    })

    return {
      loading,
      saving,
      board,
      handleIssueDrag,
    }
  },
})
</script>

<style lang="scss" scoped>
.project-board {
  overflow-x: scroll;
}
</style>
