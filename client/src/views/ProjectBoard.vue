<template>
  <article v-if="loading" uk-spinner />
  <div v-else-if="board" class="project-board">
    <draggable
      :list="board.columns"
      @change="handleColumnDrag"
      uk-grid
      class="uk-grid-small uk-flex-nowrap uk-margin-bottom"
    >
      <board-column
        v-for="column in board.columns"
        :key="column.id"
        :column="column"
        :handleIssueDrag="handleIssueDrag"
        class="uk-drag"
      />
    </draggable>
  </div>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent, watch } from 'vue'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import BoardColumn from './ProjectBoard/BoardColumn.vue'
import {
  GetProjectBoardDocument,
  namedOperations,
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
    GetProjectBoardDocument
    const { result, loading } = useGetProjectBoardQuery({
      boardId: props.boardId || '',
    })
    const board = useResult(result, null, data => {
      if (data.node?.__typename === 'Board') {
        return data.node
      }
    })
    const refetchBoardMutationOptions = {
      awaitRefetchQueries: true,
      refetchQueries: [namedOperations.Query.getProjectBoard],
    }
    const { mutate: moveBoardColumnMutation } = useMoveBoardColumnMutation({})
    const { mutate: moveBoardItemMutation } = useMoveBoardItemMutation({})

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
          refetchBoardMutationOptions,
        )
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
          refetchBoardMutationOptions,
        )
      } else if (event.added) {
        const { element, newIndex } = event.added
        const newColumn = board.value?.columns.find(column => {
          return column.items[newIndex]?.id === element.id
        })

        if (!newColumn) {
          console.error('Failed to locate column item moved to.')
          return
        }

        moveBoardItemMutation(
          {
            input: {
              itemId: element.id,
              columnId: newColumn.id,
              position: newIndex,
            },
          },
          refetchBoardMutationOptions,
        )
      }
    }

    watch(board, board => {
      if (board) {
        document.title = board.name
      }
    })

    return {
      loading,
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
