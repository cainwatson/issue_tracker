<template>
  <div v-if="loading" uk-spinner></div>
  <section v-else>
    <pre>{{ JSON.stringify(board, null, 2) }}</pre>
  </section>
</template>

<script lang="ts">
import { useResult } from '@vue/apollo-composable'
import { defineComponent } from 'vue'
import { useGetProjectBoardQuery } from '../generated/graphql'

export default defineComponent({
  name: 'ProjectBoard',
  props: {
    boardId: String,
  },
  setup(props) {
    const { result, loading } = useGetProjectBoardQuery({
      boardId: props.boardId || '',
    })
    const board = useResult(result, [], data => data.node)

    return {
      loading,
      board,
    }
  },
})
</script>
