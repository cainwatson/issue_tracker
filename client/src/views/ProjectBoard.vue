<template>
  <article v-if="loading" uk-spinner />
  <draggable
    v-else-if="board"
    :list="board.columns"
    @change="handleColumnDrag"
    uk-grid
    class="project-board uk-grid-small uk-flex-nowrap"
  >
    <board-column
      v-for="column in board.columns"
      :key="column.id"
      :column="column"
      :handleIssueDrag="handleIssueDrag"
    />
  </draggable>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { computed, defineComponent, watch } from 'vue'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import BoardColumn from './ProjectBoard/BoardColumn.vue'
import {
  useGetProjectBoardQuery,
  useMoveBoardColumnMutation,
  useMoveBoardItemMutation,
} from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBoard',
  components: {
    BoardColumn,
    Draggable,
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
      loading: loadingMoveBoardColumnMutation,
      mutate: moveBoardColumnMutation,
    } = useMoveBoardColumnMutation({})
    const {
      loading: loadingMoveBoardItemMutation,
      mutate: moveBoardItemMutation,
    } = useMoveBoardItemMutation({})
    const updating = computed(
      () => loadingMoveBoardColumnMutation || loadingMoveBoardItemMutation,
    )

    const handleColumnDrag = event => {
      if (event.moved) {
        const { element: column, newIndex } = event.moved

        moveBoardColumnMutation(
          {
            input: {
              columnId: column.id,
              position: newIndex,
            },
          },
          { awaitRefetchQueries: true },
        )
        refetchBoard()
      }
    }
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
      updating,
      board,
      handleColumnDrag,
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
