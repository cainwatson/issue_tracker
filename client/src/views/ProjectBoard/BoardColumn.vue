<template>
  <section class="uk-width-medium">
    <div
      class="uk-width-medium uk-tile uk-tile-muted uk-padding-small uk-border-rounded"
    >
      <h3>{{ column.name }}</h3>
      <draggable
        :list="column.items"
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
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { VueDraggableNext } from 'vue-draggable-next'
import { BoardColumn } from '../../generated/graphql'

export type HandleIssueDragEvent =
  | Event
  | {
      moved: {
        element: BoardColumn
        newIndex: number
        oldIndex: number
      }
    }
export type HandleIssueDragCallback = (event: HandleIssueDragEvent) => void

export default defineComponent({
  name: 'BoardColumn',
  components: {
    draggable: VueDraggableNext,
  },
  props: {
    column: {
      type: Object as PropType<BoardColumn>,
      required: true,
    },
    handleIssueDrag: {
      type: Function as PropType<HandleIssueDragCallback>,
      default: () => {
        // noop
      },
    },
  },
})
</script>
