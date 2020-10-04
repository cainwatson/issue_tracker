<template>
  <article v-if="loading" uk-spinner />
  <section v-else uk-grid class="uk-grid-small uk-child-width-auto">
    <section
      v-for="column in board.columns"
      :key="column.id"
      class="uk-width-medium"
    >
      <div class="uk-tile uk-tile-muted uk-padding-small uk-border-rounded">
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
