<template>
  <div @click="onClick">
    <slot/>
    <template v-if="loading">
      <slot name="loading" :loading-text="loadingText">
        <div class="hint loading">{{loadingText}}</div>
      </slot>
    </template>
    <template v-else-if="errmsg">
      <slot name="error" :errmsg="errmsg">
        <div class="hint error">{{errmsg}}</div>
      </slot>
    </template>
    <template v-else-if="finished && !isEmpty">
      <slot name="finished" :finish-text="finishText">
        <div class="hint finished">{{finishText}}</div>
      </slot>
    </template>
    <template v-else-if="finished && isEmpty">
      <slot name="empty" :empty-text="emptyText">
        <div class="hint empty">{{emptyText}}</div>
      </slot>
    </template>
    <template v-else>
      <slot name="normal" :normal-text="normalText">
        <div class="hint normal">{{normalText}}</div>
      </slot>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    /**
     * 数据是否为空
     */
    isEmpty: Boolean,
    /**
     * 触发加载时调用的函数，异步返回是否加载完成
     */
    onLoadmore: Function,
    /**
     * 加载时的提示文字
     */
    loadingText: {
      type: String,
      default: '正在加载...'
    },
    /**
     * 默认的错误提示文字
     */
    errorText: {
      type: String,
      default: '加载失败，点击重试'
    },
    /**
     * 全部加载完成时的提示文字
     */
    finishText: {
      type: String,
      default: '没有更多了'
    },
    /**
     * 没有数据时的提示文字
     */
    emptyText: {
      type: String,
      default: '暂无数据'
    },
    /**
     * 默认提示文字
     */
    normalText: {
      type: String,
      default: '点击加载更多'
    }
  },

  data() {
    return {
      /**
       * 是否正在加载
       */
      loading: false,
      /**
       * 是否全部加载完成
       */
      finished: false,
      /**
       * 错误信息
       */
      errmsg: '',
      /**
       * 是否监听自身滚动
       */
      scrollable: !!this.$slots.default
    };
  },

  methods: {
    /**
     * 滚动到底部时，触发加载更多
     */
    onScroll() {
      if (this.finished || this.loading) return;
      const scrollHeight = this.scrollable
        ? this.$el.scrollHeight
        : document.body.scrollHeight ||
          document.documentElement.scrollHeight ||
          0;
      const scrollTop = this.scrollable
        ? this.$el.scrollTop
        : document.body.scrollTop ||
          document.documentElement.scrollTop ||
          window.pageYOffset ||
          window.scrollY ||
          0;
      const clientHeight = this.scrollable
        ? this.$el.clientHeight
        : window.innerHeight ||
          document.documentElement.clientHeight ||
          document.body.clientHeight ||
          0;
      if (scrollHeight - scrollTop - clientHeight < 50) {
        this.loadmore();
      }
    },

    /**
     * 部分状态下点击可触发加载更多
     */
    onClick() {
      if (this.finished || this.loading) return;
      this.loadmore();
    },

    /**
     * 手动触发加载更多
     */
    async loadmore() {
      if (this.loading) return;
      if (typeof this.onLoadmore !== 'function') return;
      this.loading = true;
      this.errmsg = '';
      try {
        const finished = !!(await this.onLoadmore());
        this.finished = finished;
      } catch (err) {
        this.errmsg = err.message || this.errorText;
      } finally {
        this.loading = false;
      }
    }
  },

  mounted() {
    const overflow = getComputedStyle(this.$el).overflow;
    this.scrollable = overflow === 'auto' || overflow === 'scroll';
    const element = this.scrollable ? this.$el : window;
    element.addEventListener('scroll', this.onScroll);
  },

  beforeDestroy() {
    const element = this.scrollable ? this.$el : window;
    element.removeEventListener('scroll', this.onScroll);
  }
};
</script>

<style scoped>
.hint {
  line-height: 3em;
  text-align: center;
}
</style>
