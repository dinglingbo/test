/**
 * @file 上拉加载更多
 *
 * 将向`data`中注入以下表示状态属性：
 * @prop {boolean} loading 是否正在加载（正在请求数据）
 * @prop {string} errmsg 加载失败时的错误提示信息
 * @prop {boolean} finished 是否全部加载完成
 *
 * 将向methods中注入以下函数：
 * @method onScroll 页面滚动时调用
 * @method onReachBottom 页面滚动到底部时调用
 *
 * 需要提供的函数：
 * @method loadmore 调用后自动加载更多数据
**/

import axios from 'axios'

export default ({
  loadmore = 'loadmore',
  onScroll = 'onScroll',
  onReachBottom = 'onReachBottom',
  loading = 'loading',
  errmsg = 'errmsg',
  finished = 'finished'
} = {}) => {
  return {
    data() {
      return {
        [loading]: false,
        [errmsg]: '',
        [finished]: false
      }
    },

    created() {
      this[onScroll] = this[onScroll].bind(this)
    },

    mounted() {
      window.addEventListener('scroll', this[onScroll])
    },

    beforeDestroy() {
      window.removeEventListener('scroll', this[onScroll])
    },

    methods: {
      [onScroll]() {
        const scrollHeight = document.body.scrollHeight || document.documentElement.scrollHeight || 0;
        const clientHeight = window.innerHeight || 0;
        const scrollTop = document.body.scrollTop || document.documentElement.scrollTop || 0;
        if (scrollHeight - clientHeight - scrollTop < 50) {
          this[onReachBottom]()
        }
      },

      async [onReachBottom]() {
        if (this[finished]) return
        if (this[loading]) return
        this[loading] = true;
        this[errmsg] = '';
        try {
          await this[loadmore]()
          this.loading = false
        } catch (err) {
          if (!axios.isCancel(err)) {
            this.errmsg = err.message || '加载失败'
            this.loading = false
          }
        }
      }
    }
  }
}
