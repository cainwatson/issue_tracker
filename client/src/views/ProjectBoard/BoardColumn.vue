<template>
  <div class="uk-width-medium">
    <section
      class="uk-width-medium uk-height-1-1 uk-tile uk-tile-muted uk-padding-small uk-border-rounded"
    >
      <h3>{{ column.name }}</h3>
      <draggable
        :list="column.items"
        @change="handleIssueDrag"
        tag="ol"
        class="uk-list"
      >
        <li v-for="item in column.items" :key="item.id" class="uk-drag">
          <article
            class="uk-card uk-card-body uk-card-default uk-card-small uk-margin-bottom"
          >
            <h5>{{ item.issue.summary }}</h5>
            <p>{{ item.issue.description }}</p>
          </article>
        </li>
      </draggable>
    </section>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { VueDraggableNext } from 'vue-draggable-next'
import { BoardColumn } from '../../generated/graphql'

export type HandleDragEvent<E> =
  | Event
  | {
      moved: {
        element: E
        newIndex: number
        oldIndex: number
      }
    }
export type HandleDragCallback<E> = (event: HandleDragEvent<E>) => void

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
      type: Function as PropType<HandleDragCallback<BoardColumn>>,
      default: () => {
        // noop
      },
    },
  },
})
</script>
