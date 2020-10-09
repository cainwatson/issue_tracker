<template>
  <div class="uk-width-medium">
    <section
      class="uk-width-medium uk-height-1-1 uk-tile uk-tile-muted uk-padding-small uk-border-rounded"
    >
      <h3>{{ column.name }}</h3>
      <draggable
        group="board-item"
        :list="column.items"
        @change="handleIssueDrag"
        tag="ol"
        class="uk-list uk-height-1-1"
      >
        <li v-for="item in column.items" :key="item.id" class="uk-drag">
          <board-item :item="item" />
        </li>
      </draggable>
    </section>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue'
import { VueDraggableNext as Draggable } from 'vue-draggable-next'
import BoardItem from './BoardItem.vue'
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
  | {
      added: {
        element: E
        newIndex: number
      }
    }
  | {
      removed: {
        element: E
        oldIndex: number
      }
    }
export type HandleDragCallback<E> = (event: HandleDragEvent<E>) => void

export default defineComponent({
  name: 'BoardColumn',
  components: {
    BoardItem,
    Draggable,
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
