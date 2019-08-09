<template>
  <div class="btn-area">
    <div class="btn-wrapper" :class="{ fixed }">
      <slot/>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    fixed: Boolean
  }
};
</script>

<style>
.btn-area {
  height: 1rem;
}

.btn-wrapper {
  display: flex;
  height: inherit;
  box-sizing: border-box;
  padding: 0.16rem 0.32rem;
  background-color: inherit;
}

.btn-wrapper.fixed {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
}

.btn-area button {
  height: 100%;
  border-radius: 0.1rem;
  border: none;
  outline: none;
  font-size: 0.36rem;
  flex: 1;
  color: #fff;
  background-color: #3087f7;
}
</style>
