<template>
  <article v-if="loading" uk-spinner />
  <div
    v-else-if="board"
    uk-grid
    class="project-board uk-grid-small uk-flex-nowrap"
  >
    <section
      v-for="column in board.columns"
      :key="column.id"
      class="uk-width-medium"
    >
      <div
        class="uk-width-medium uk-tile uk-tile-muted uk-padding-small uk-border-rounded"
      >
        <h3>{{ column.name }}</h3>
        <draggable
          v-model="column.items"
          @change="handleIssueDrag"
          tag="ol"
          class="uk-list"
        >
          <li v-for="item in column.items" :key="item.id">
            <article
              class="uk-card uk-card-body uk-card-default uk-card-small uk-margin-bottom"
            >
              <h5>{{ item.issue.summary }}</h5>
              <p>{{ item.issue.description }}</p>
            </article>
          </li>
        </draggable>
      </div>
    </section>
  </div>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent, watch } from 'vue'
import { VueDraggableNext } from 'vue-draggable-next'
import {
  useGetProjectBoardQuery,
  useMoveBoardItemMutation,
} from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBoard',
  components: {
    draggable: VueDraggableNext,
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
