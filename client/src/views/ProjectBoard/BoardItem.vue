<template>
  <article
    class="uk-card uk-card-body uk-card-default uk-card-small uk-margin-bottom"
  >
    <h5>{{ item.issue.summary }}</h5>
    <p>{{ item.issue.description }}</p>
  </article>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { BoardItem } from '../../generated/graphql'

export default defineComponent({
  name: 'BoardItem',
  props: {
    item: {
      type: Object as PropType<BoardItem>,
      required: true,
    },
  },
})
</script>
